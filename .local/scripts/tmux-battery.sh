#!/bin/bash
# Fast macOS-native battery script for tmux status bar

# Get battery info once
battery_info=$(pmset -g batt | grep -Eo "([0-9]+)%;.*" | head -1)

# Extract percentage (first number before %)
percentage=${battery_info%%;*}
percentage=${percentage%%%*}

# Check if charging (look for "AC" or "charging" in the line)
if [[ $battery_info == *"AC"* ]] || [[ $battery_info == *"charging"* ]]; then
    icon="⚡"
elif [ "$percentage" -ge 90 ]; then
    icon="█"
elif [ "$percentage" -ge 60 ]; then
    icon="▆"
elif [ "$percentage" -ge 40 ]; then
    icon="▄"
elif [ "$percentage" -ge 20 ]; then
    icon="▂"
else
    icon="▁"
fi

echo "$icon $percentage%"
