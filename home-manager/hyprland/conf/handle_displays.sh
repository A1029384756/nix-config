#!/bin/bash

function disp_mgmt {
  monitors=$(hyprctl -j monitors)
  num_displays=$(echo $monitors | jq length)
  sleep 0.1

  declare -i monitor_idx;
  declare -i i; i=1
  declare -i offset; offset=0
  until [ $i -gt $num_displays ]
  do
    monitor_idx=$(($num_displays-$i))
    name=$(echo $monitors | jq -r .[$monitor_idx].name)
    width=$(echo $monitors | jq .[$monitor_idx].width)
    height=$(echo $monitors | jq .[$monitor_idx].height)
    refresh_rate=$(printf '%.0f' "$(echo $monitors | jq .[$monitor_idx].refreshRate)")
  
    hyprctl keyword monitor ${name},${width}x${height}@${refresh_rate},${offset}x0,1 &> /dev/null
    sleep 0.1
    hyprctl hyprpaper wallpaper "$name,~/.config/hypr/bg.png" &> /dev/null
    sleep 0.1
  
    offset+=$width
    i+=1
  done
}

function handle_connections {
  if [[ $1 == "monitoradded"* ]]; then
    disp_mgmt
  elif [[ $1 == "monitorremoved"* ]]; then
    disp_mgmt
  fi
}

disp_mgmt
socat - "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle_connections "$line"; done
