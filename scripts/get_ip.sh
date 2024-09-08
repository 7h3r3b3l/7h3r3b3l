#!/bin/bash
local_ip=$(ifconfig wlan0  | head -n 2 | tail -n 1 | cut -d " " -f 10-11 | tr -d " ")
curl ipinfo.io | jq -r '[.city, .ip] | @csv' | tr -d '"' | tr "," " "| while read city ip; do
  echo "$(cat /etc/hostname) | $city | $local_ip | $ip" | tee -a ~/.iplogs.txt
done | /home/r/.pdtm/go/bin/notify -silent
