#!/bin/bash

ADAPTER="8C:68:8B:61:0C:51"
MAX_RETRIES=10
CONNECT_TIMEOUT=10

# --- Données des devices connus ---
declare -A DEVICE_MAC DEVICE_CARD DEVICE_SINK
DEVICE_MAC[casque]="E4:22:A5:30:67:BF"
DEVICE_CARD[casque]="bluez_card.E4_22_A5_30_67_BF"
DEVICE_SINK[casque]="bluez_sink.E4_22_A5_30_67_BF.a2dp_sink"

DEVICE_MAC[openrun]="A8:F5:E1:CC:CB:EA"
DEVICE_CARD[openrun]="bluez_card.A8_F5_E1_CC_CB_EA"
DEVICE_SINK[openrun]="bluez_sink.A8_F5_E1_CC_CB_EA.a2dp_sink"

COMBINED_SINK_NAME="combined_bt"
COMBINED_SINK_DESC="Combined BT Output"

# --- Parsing des arguments ---

RESET=false
TARGETS=()

for arg in "$@"; do
    case "$arg" in
        --reset) RESET=true ;;
        --*) echo "Option inconnue : $arg" >&2; exit 1 ;;
        *) TARGETS+=("$arg") ;;
    esac
done

if [[ ${#TARGETS[@]} -eq 0 ]]; then
    echo "Usage: $0 [--reset] <sink1> [sink2 ...]"
    echo "Sinks disponibles : ${!DEVICE_MAC[*]}"
    exit 1
fi

for t in "${TARGETS[@]}"; do
    if [[ -z "${DEVICE_MAC[$t]+x}" ]]; then
        echo "Sink inconnu : '$t'. Disponibles : ${!DEVICE_MAC[*]}" >&2
        exit 1
    fi
done

# --- Fonctions Bluetooth ---

# Wrapper : toute commande bluetoothctl passe par ici pour
# garantir que l'adaptateur externe est sélectionné.
btctl() {
    { echo "select $ADAPTER"; printf '%s\n' "$@"; } | bluetoothctl 2>&1
}

adapter_available() {
    bluetoothctl show "$ADAPTER" 2>/dev/null | grep -q "Controller"
}

reset_adapter() {
    echo "Redémarrage dur de l'adaptateur…"
    killall blueman-manager 2>/dev/null
    sudo systemctl stop bluetooth
    sleep 0.3
    rfkill block bluetooth && sleep 0.2
    rfkill unblock bluetooth && sleep 0.2
    sudo modprobe -r btusb && sleep 0.2
    sudo modprobe btusb && sleep 1.0
    sudo systemctl start bluetooth && sleep 0.5
}

wait_for_adapter() {
    local retries=0
    while ! adapter_available; do
        (( retries++ ))
        if (( retries > MAX_RETRIES )); then
            echo "Adaptateur introuvable après $MAX_RETRIES essais, abandon."
            exit 1
        fi
        echo "Adaptateur non disponible, tentative $retries/$MAX_RETRIES…"
        reset_adapter
    done
    echo "Adaptateur disponible."
}

is_connected() {
    local mac="$1"
    btctl "info $mac" | grep -q "Connected: yes"
}

wait_for_device() {
    local name="$1"
    local mac="${DEVICE_MAC[$name]}"
    local retries=0

    echo "[$name] Attente que le device soit visible ($mac)…"
    while ! btctl "devices" | grep -q "$mac"; do
        (( retries++ ))
        if (( retries > 20 )); then
            echo "[$name] Device toujours invisible après 20s."
            return 1
        fi
        sleep 1
    done
    echo "[$name] Device visible."
}

connect_device() {
    local name="$1"
    local mac="${DEVICE_MAC[$name]}"
    local retries=0

    while (( retries < MAX_RETRIES )); do
        (( retries++ ))
        echo "[$name] Tentative de connexion $retries/$MAX_RETRIES…"

        if is_connected "$mac"; then
            echo "[$name] Déjà connecté."
            return 0
        fi

        local output
        output=$(
            {
                echo "select $ADAPTER"
                echo "power on"
                sleep 0.5
                echo "connect $mac"
                sleep "$CONNECT_TIMEOUT"
            } | bluetoothctl 2>&1
        )

        echo "$output" | grep -v '^$' | sed 's/^/  /'

        if echo "$output" | grep -qi "connection successful\|connecté"; then
            echo "[$name] Connecté."
            return 0
        fi

        if is_connected "$mac"; then
            echo "[$name] Connecté (détecté via info)."
            return 0
        fi

        echo "[$name] Échec, nouvelle tentative dans 2s…"
        sleep 2
    done

    echo "[$name] Impossible de connecter après $MAX_RETRIES tentatives."
    return 1
}

wait_for_pa_sink() {
    local name="$1"
    local sink="${DEVICE_SINK[$name]}"
    local retries=0

    echo "[$name] Attente du sink PulseAudio ($sink)…"
    while ! pactl list sinks short 2>/dev/null | grep -q "$sink"; do
        (( retries++ ))
        if (( retries > 15 )); then
            echo "[$name] Sink introuvable après $retries essais."
            return 1
        fi
        sleep 1
    done
    echo "[$name] Sink prêt."
}

apply_latency_offset() {
    local name="$1"
    local card="${DEVICE_CARD[$name]}"
    local retries=0

    while ! pactl list cards short 2>/dev/null | grep -q "$card"; do
        (( retries++ ))
        if (( retries > 10 )); then
            echo "[$name] Carte audio introuvable, skip latency offset."
            return
        fi
        sleep 1
    done
    echo "[$name] Application du latency offset (50ms)…"
    pactl set-port-latency-offset "$card" headset-output 50000
}

# --- Combinaison multi-sink via null sink + loopback ---

setup_combined_sink() {
    local sinks=("$@")

    # Nettoyage : supprimer les anciens modules loopback et null sink
    local mod_ids
    mod_ids=$(pactl list short modules 2>/dev/null \
        | awk '/module-loopback/ {print $1}')
    for mid in $mod_ids; do
        # Ne supprimer que ceux liés à notre combined sink
        if pactl list modules 2>/dev/null | grep -A5 "Module #$mid" \
            | grep -q "$COMBINED_SINK_NAME"; then
            pactl unload-module "$mid" 2>/dev/null
        fi
    done

    mod_ids=$(pactl list short modules 2>/dev/null \
        | awk '/module-null-sink/ && /'"$COMBINED_SINK_NAME"'/ {print $1}')
    for mid in $mod_ids; do
        echo "Suppression de l'ancien null sink (module #$mid)…"
        pactl unload-module "$mid" 2>/dev/null
    done

    echo "Création du null sink '$COMBINED_SINK_NAME'…"
    if ! pactl load-module module-null-sink sink_name="$COMBINED_SINK_NAME" > /dev/null; then
        echo "Erreur : impossible de créer le null sink."
        return 1
    fi

    for name in "${sinks[@]}"; do
        local sink="${DEVICE_SINK[$name]}"
        echo "[$name] Loopback : $COMBINED_SINK_NAME → $sink"
        if ! pactl load-module module-loopback source="${COMBINED_SINK_NAME}.monitor" sink="$sink" latency_msec=50 > /dev/null; then
            echo "[$name] Erreur : impossible de créer le loopback."
            return 1
        fi
    done

    echo "Sink par défaut : $COMBINED_SINK_NAME"
    pactl set-default-sink "$COMBINED_SINK_NAME"
}

# --- Main ---

rfkill unblock bluetooth

if $RESET; then
    reset_adapter
    wait_for_adapter
fi

for t in "${TARGETS[@]}"; do
    wait_for_device "$t" || exit 1
done

for t in "${TARGETS[@]}"; do
    connect_device "$t" || exit 1
done

for t in "${TARGETS[@]}"; do
    wait_for_pa_sink "$t" || exit 1
    apply_latency_offset "$t"
done

if [[ ${#TARGETS[@]} -gt 1 ]]; then
    setup_combined_sink "${TARGETS[@]}"
else
    name="${TARGETS[0]}"
    echo "Un seul sink, réglage direct : ${DEVICE_SINK[$name]}"
    pactl set-default-sink "${DEVICE_SINK[$name]}"
fi

setxkbmap fr bepoz
