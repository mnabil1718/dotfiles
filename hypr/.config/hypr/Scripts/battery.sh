#!/bin/bash

BAT=/sys/class/power_supply/BAT1
capacity=$(cat $BAT/capacity)
status=$(cat $BAT/status)

if [ "$status" = "Charging" ]; then
    icon="󰂄"
elif [ "$capacity" -ge 90 ]; then
    icon="󰁹"
elif [ "$capacity" -ge 70 ]; then
    icon="󰂀"
elif [ "$capacity" -ge 50 ]; then
    icon="󰁾"
elif [ "$capacity" -ge 30 ]; then
    icon="󰁼"
elif [ "$capacity" -ge 10 ]; then
    icon="󰁺"
else
    icon="󰂃"  # critical
fi

echo "$icon $capacity%"
