#!/bin/bash
curl ipinfo.io | jq -r '[.city, .ip] | @csv'  | tr -d '"' | tr ",", " " | tee -a ~/.iplogs.txt
