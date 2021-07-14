#!/usr/bin/zsh -i

# need the two screens
~/.screenlayout/both-hdmi-dvi.sh


base_path='/home/lucas/Aspyrine'

# Workplace
open-kitty "$base_path" wk-2 ls
open-kitty "$base_path" wk-3 ls
open-kitty "$base_path" wk-4 ls


# open OBS and a Firefox with a Twitch-dedicated profile

# see https://unix.stackexchange.com/a/231328/185486
#  for the nohup and &! tricks
# see https://superuser.com/a/1181354
#  for firefox class name magic
nohup firefox --no-remote -P Twitch --class TwitchFirefox &!
nohup obs &!


# wait for windows to open (probably not in their correct workspaces)
sleep 3


# for each created window, ensure it is on the right workspace
i3-msg '[class="wk-2"] move to workspace 2'
i3-msg '[class="wk-3"] move to workspace 3'
i3-msg '[class="wk-4"] move to workspace 4'
i3-msg '[class="TwitchFirefox"] move to workspace 1'


# for each created workspace, ensure it is on the right output
# NB: be sure that workspaces exists if you want to move them
# streamed
i3-msg workspace 4 ; i3-msg move workspace to output HDMI-0
i3-msg workspace 3 ; i3-msg move workspace to output HDMI-0
i3-msg workspace 2 ; i3-msg move workspace to output HDMI-0
i3-msg workspace 1 ; i3-msg move workspace to output HDMI-0
# private
i3-msg workspace  ; i3-msg move workspace to output DVI-I-0
i3-msg workspace  ; i3-msg move workspace to output DVI-I-0
i3-msg workspace  ; i3-msg move workspace to output DVI-I-0
i3-msg workspace  ; i3-msg move workspace to output DVI-I-0
