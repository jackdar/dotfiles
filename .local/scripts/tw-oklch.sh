#!/bin/sh

script_dir=$(dirname "$0")

# If no args take user input
if [ $# -eq 0 ]; then
  echo "Please enter the tailwind colour name (e.g. 'blue-500'): "
  read colour_name
else
  colour_name=$1
fi

# Read 'variables.txt' file and extract the oklch value after the colon
oklch_value=$(sed -n "s/^$colour_name:[[:space:]]*//p" "$script_dir/tw-variables.txt")

# Copy the string to the user's clipboard (macos) and repeat to the user
echo "The oklch value for $colour_name has been copied to your clipboard: $oklch_value"
echo "$oklch_value" | pbcopy
