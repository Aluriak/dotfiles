#!/bin/bash

# =============================================================================
# bluetooth.sh — gestion Bluetooth en ligne de commande
#
# Usage:
#   bluetooth.sh reset                        Redémarre l'adaptateur
#   bluetooth.sh connect <dev> [dev2 ...]     Connecte un ou plusieurs devices
#   bluetooth.sh connect <dev> --reset        Reset puis connecte
#   bluetooth.sh connect <dev> --gui          Lance blueman-manager après connexion
#   bluetooth.sh disconnect <dev> [dev2 ...]  Déconnecte
#   bluetooth.sh status [dev ...]             État des devices (tous si omis)
#   bluetooth.sh list                         Liste les devices connus
#   bluetooth.sh help                         Affiche cette aide
# =============================================================================

ADAPTER="8C:68:8B:61:0C:51"
MAX_RETRIES=10
CONNECT_TIMEOUT=10

# --- Devices connus ---

declare -A DEVICE_MAC DEVICE_CARD DEVICE_SINK

DEVICE_MAC[casque]="E4:22:A5:30:67:BF"
DEVICE_CARD[casque]="bluez_card.E4_22_A5_30_67_BF"
DEVICE_SINK[casque]="bluez_sink.E4_22_A5_30_67_BF.a2dp_sink"

DEVICE_MAC[openrun]="A8:F5:E1:CC:CB:EA"
DEVICE_CARD[openrun]="bluez_card.A8_F5_E1_CC_CB_EA"
DEVICE_SINK[openrun]="bluez_sink.A8_F5_E1_CC_CB_EA.a2dp_sink"

COMBINED_SINK_NAME="combined_bt"

# =============================================================================
# Utilitaires Bluetooth
# =============================================================================

btctl() {
    { echo "select $ADAPTER"; printf '%s\n' "$@"; } | bluetoothctl 2>&1
}

adapter_available() {
    bluetoothctl show "$ADAPTER" 2>/dev/null | grep -q "Controller"
}

is_connected() {
    local mac="$1"
    btctl "info $mac" | grep -q "Connected: yes"
}

require_known_device() {
    local name="$1"
    if [[ -z "${DEVICE_MAC[$name]+x}" ]]; then
        echo "Device inconnu : '$name'. Disponibles : ${!DEVICE_MAC[*]}" >&2
        exit 1
    fi
}

# =============================================================================
# Sous-commande : reset
# =============================================================================

cmd_reset() {
    echo "Redémarrage de l'adaptateur Bluetooth…"
    killall blueman-manager 2>/dev/null
    sudo systemctl stop bluetooth
    sleep 0.3
    rfkill block bluetooth   && sleep 0.2
    rfkill unblock bluetooth && sleep 0.2
    sudo modprobe -r btusb   && sleep 0.2
    sudo modprobe btusb      && sleep 1.0
    sudo systemctl start bluetooth && sleep 0.5

    local retries=0
    while ! adapter_available; do
        (( retries++ ))
        if (( retries > MAX_RETRIES )); then
            echo "Adaptateur introuvable après $MAX_RETRIES essais, abandon." >&2
            exit 1
        fi
        echo "Attente de l'adaptateur… ($retries/$MAX_RETRIES)"
        sleep 1
    done

    btctl "power on" > /dev/null
    echo "Adaptateur prêt."
}

# =============================================================================
# Sous-commande : connect
# =============================================================================

_wait_for_device() {
    local name="$1" mac="${DEVICE_MAC[$1]}" retries=0
    echo "[$name] Attente que le device soit visible ($mac)…"
    while ! btctl "devices" | grep -q "$mac"; do
        (( retries++ ))
        if (( retries > 20 )); then
            echo "[$name] Device toujours invisible après 20s." >&2
            return 1
        fi
        sleep 1
    done
    echo "[$name] Device visible."
}

_connect_device() {
    local name="$1" mac="${DEVICE_MAC[$1]}" retries=0

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

        if echo "$output" | grep -qi "connection successful\|connecté" || is_connected "$mac"; then
            echo "[$name] Connecté."
            return 0
        fi

        echo "[$name] Échec, nouvelle tentative dans 2s…"
        sleep 2
    done

    echo "[$name] Impossible de connecter après $MAX_RETRIES tentatives." >&2
    return 1
}

_wait_for_pa_sink() {
    local name="$1" sink="${DEVICE_SINK[$1]}" retries=0
    echo "[$name] Attente du sink PulseAudio ($sink)…"
    while ! pactl list sinks short 2>/dev/null | grep -q "$sink"; do
        (( retries++ ))
        if (( retries > 15 )); then
            echo "[$name] Sink introuvable après $retries essais." >&2
            return 1
        fi
        sleep 1
    done
    echo "[$name] Sink prêt."
}

_apply_latency_offset() {
    local name="$1" card="${DEVICE_CARD[$1]}" retries=0
    while ! pactl list cards short 2>/dev/null | grep -q "$card"; do
        (( retries++ ))
        if (( retries > 10 )); then
            echo "[$name] Carte audio introuvable, skip latency offset."
            return
        fi
        sleep 1
    done
    echo "[$name] Latency offset → 50ms"
    pactl set-port-latency-offset "$card" headset-output 50000
}

_setup_combined_sink() {
    local sinks=("$@")

    # Nettoyage des loopbacks liés à combined_bt
    local mod_ids
    mod_ids=$(pactl list short modules 2>/dev/null | awk '/module-loopback/ {print $1}')
    for mid in $mod_ids; do
        if pactl list modules 2>/dev/null | grep -A5 "Module #$mid" | grep -q "$COMBINED_SINK_NAME"; then
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
        echo "Erreur : impossible de créer le null sink." >&2
        return 1
    fi

    for name in "${sinks[@]}"; do
        local sink="${DEVICE_SINK[$name]}"
        echo "[$name] Loopback : $COMBINED_SINK_NAME → $sink"
        if ! pactl load-module module-loopback \
            source="${COMBINED_SINK_NAME}.monitor" sink="$sink" latency_msec=50 > /dev/null; then
            echo "[$name] Erreur : impossible de créer le loopback." >&2
            return 1
        fi
    done

    pactl set-default-sink "$COMBINED_SINK_NAME"
    echo "Sink par défaut : $COMBINED_SINK_NAME"
}

cmd_connect() {
    local do_reset=false do_gui=false
    local targets=()

    for arg in "$@"; do
        case "$arg" in
            --reset) do_reset=true ;;
            --gui)   do_gui=true ;;
            --*)     echo "Option inconnue : $arg" >&2; exit 1 ;;
            *)       targets+=("$arg") ;;
        esac
    done

    if [[ ${#targets[@]} -eq 0 ]]; then
        echo "Usage: $0 connect <device> [device2 ...] [--reset] [--gui]" >&2
        echo "Devices disponibles : ${!DEVICE_MAC[*]}" >&2
        exit 1
    fi

    for t in "${targets[@]}"; do require_known_device "$t"; done

    rfkill unblock bluetooth

    if $do_reset; then cmd_reset; fi

    for t in "${targets[@]}"; do _wait_for_device "$t"  || exit 1; done
    for t in "${targets[@]}"; do _connect_device "$t"   || exit 1; done
    for t in "${targets[@]}"; do
        _wait_for_pa_sink "$t"    || exit 1
        _apply_latency_offset "$t"
    done

    if [[ ${#targets[@]} -gt 1 ]]; then
        _setup_combined_sink "${targets[@]}"
    else
        local name="${targets[0]}"
        echo "Sink par défaut : ${DEVICE_SINK[$name]}"
        pactl set-default-sink "${DEVICE_SINK[$name]}"
    fi

    setxkbmap fr bepoz

    if $do_gui; then
        blueman-manager &
    fi
}

# =============================================================================
# Sous-commande : disconnect
# =============================================================================

cmd_disconnect() {
    local targets=("$@")

    if [[ ${#targets[@]} -eq 0 ]]; then
        echo "Usage: $0 disconnect <device> [device2 ...]" >&2
        echo "Devices disponibles : ${!DEVICE_MAC[*]}" >&2
        exit 1
    fi

    for t in "${targets[@]}"; do
        require_known_device "$t"
        local mac="${DEVICE_MAC[$t]}"
        echo "[$t] Déconnexion…"
        btctl "disconnect $mac" | grep -v '^$' | sed 's/^/  /'
    done
}

# =============================================================================
# Sous-commande : status
# =============================================================================

cmd_status() {
    local targets=("$@")

    # Si aucun device précisé, afficher tous les connus
    if [[ ${#targets[@]} -eq 0 ]]; then
        targets=("${!DEVICE_MAC[@]}")
    fi

    for t in "${targets[@]}"; do
        require_known_device "$t"
        local mac="${DEVICE_MAC[$t]}"
        if is_connected "$mac"; then
            echo "[$t] ✓ connecté ($mac)"
        else
            echo "[$t] ✗ non connecté ($mac)"
        fi
    done
}

# =============================================================================
# Sous-commande : list
# =============================================================================

cmd_list() {
    echo "Devices connus :"
    for name in "${!DEVICE_MAC[@]}"; do
        printf "  %-12s %s\n" "$name" "${DEVICE_MAC[$name]}"
    done
}

# =============================================================================
# Sous-commande : help
# =============================================================================

cmd_help() {
    cat <<EOF
Usage: $(basename "$0") <commande> [options]

Commandes :
  reset                          Redémarre l'adaptateur Bluetooth
  connect <dev> [dev2 ...]       Connecte un ou plusieurs devices
    --reset                        Reset l'adaptateur avant de connecter
    --gui                          Lance blueman-manager après connexion
  disconnect <dev> [dev2 ...]    Déconnecte un ou plusieurs devices
  status [dev ...]               État des devices (tous si omis)
  list                           Liste les devices connus
  help                           Affiche cette aide

Exemples :
  $(basename "$0") reset
  $(basename "$0") connect openrun
  $(basename "$0") connect openrun --reset --gui
  $(basename "$0") connect casque openrun
  $(basename "$0") disconnect openrun
  $(basename "$0") status
EOF
}

# =============================================================================
# Dispatch
# =============================================================================

case "${1:-}" in
    reset)      shift; cmd_reset "$@" ;;
    connect)    shift; cmd_connect "$@" ;;
    disconnect) shift; cmd_disconnect "$@" ;;
    status)     shift; cmd_status "$@" ;;
    list)       shift; cmd_list "$@" ;;
    help|--help|-h) cmd_help ;;
    "")         cmd_help; exit 1 ;;
    *)          echo "Commande inconnue : '$1'" >&2; cmd_help; exit 1 ;;
esac
