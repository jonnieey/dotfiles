#!/usr/bin/bash
export DISPLAY=:0
BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
BAT1=$(cat /sys/class/power_supply/BAT1/capacity)

STATUS0=$(cat /sys/class/power_supply/BAT0/status) # Charging/Discharging/Full/Unknown/Not charging
STATUS1=$(cat /sys/class/power_supply/BAT1/status)

# Check if either battery is below 20%
if [[ $BAT0 -le 20 || $BAT1 -le 20 ]]; then
  notify-send -t 7000 -u normal "Low Battery Warning" "Battery 0: $BAT0% ($STATUS0)\nBattery 1: $BAT1% ($STATUS1)"
fi

# Check if both batteries are below 40%
if [[ $BAT0 -le 40 && $BAT1 -le 40 ]]; then
  notify-send -t 10000 -u critical "Critical Battery Warning" "Both batteries are low!\nBattery 0: $BAT0% ($STATUS0)\nBattery 1: $BAT1% ($STATUS1)"
fi

# Check if both batteries are below 5% and NOT charging, then suspend
if [[ $BAT0 -le 5 && $BAT1 -le 5 ]] && [[ $STATUS0 =~ "Discharging|Full|Not charging|Unknown" && $STATUS1 =~ "Discharging|Full|Not charging|Unknown" ]]; then
  notify-send -t 10000 -u critical "Suspending System" "Battery critically low! Suspending..."
  sleep 5 # Give user a few seconds to see the notification
  systemctl suspend
fi
