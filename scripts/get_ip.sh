#!/bin/bash
curl ipinfo.io | jq -r '[.city, .ip] | @csv'  | tr -d '"' | tr ",", " "  
