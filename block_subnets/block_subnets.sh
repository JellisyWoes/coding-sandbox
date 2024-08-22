#!/bin/bash

# Define an array of subnets to block
subnets=(
  "YOUR_SUBNETS_HERE"
)

# Define the general comment to be added to each block
comment="Blocked Subnet"

# Define the log file (replace with your actual path)
log_file="YOUR_LOG_PATH_HERE/block_subnets.log"

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 
  exit 1
fi

# Loop through each subnet in the array and block it
for subnet in "${subnets[@]}"
do
  if [[ -n "$subnet" ]]; then
    # Check if the subnet is already blocked
    if sudo ufw status | grep -q "$subnet"; then
      echo "Subnet $subnet is already blocked. Skipping..."
      echo "$(date): Subnet $subnet is already blocked. Skipping..." >> "$log_file"
    else
      echo "Blocking subnet: $subnet with comment: $comment"
      sudo ufw reject from "$subnet" comment "$comment"
      if [[ $? -eq 0 ]]; then
        echo "$(date): Blocked $subnet" >> "$log_file"
      else
        echo "$(date): Failed to block $subnet" >> "$log_file"
      fi
    fi
  fi
done

echo "All specified subnets have been processed. Check $log_file for details."
