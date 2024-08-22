#!/bin/bash

# Define URLs to fetch Cloudflare IP ranges
ipv4_url="https://www.cloudflare.com/ips-v4"
ipv6_url="https://www.cloudflare.com/ips-v6"

# Fetch Cloudflare IP ranges
echo "Fetching Cloudflare IP ranges..."
ipv4_ranges=$(curl -s $ipv4_url)
ipv6_ranges=$(curl -s $ipv6_url)

# Define the ports that need to be opened (customize as needed)
ports="YOUR_PORTS_HERE"

# Define the output file
output_file="cloudflare_ufw_rules.txt"
temp_file=$(mktemp)

# Get current timestamp
timestamp=$(date +"%a %b %d %T %Z %Y")

# Write header to the temp file
{
    echo "Timestamp: $timestamp"
    echo "Ports: $ports"
    echo "IPv4:"
    echo "$ipv4_ranges"
    echo "IPv6:"
    echo "$ipv6_ranges"
} > $temp_file

# Function to compare files ignoring the first line (timestamp)
compare_files_ignore_timestamp() {
    diff -q <(tail -n +2 "$1") <(tail -n +2 "$2") > /dev/null
}

# Compare temp file with existing output file ignoring the timestamp
if [ -f "$output_file" ]; then
    if compare_files_ignore_timestamp "$temp_file" "$output_file"; then
        echo "No changes in IP ranges or ports. No UFW rules added."
        rm "$temp_file"
        exit 0
    else
        echo "Changes detected in IP ranges or ports. Updating UFW rules."
    fi
fi

# Clear existing Cloudflare UFW rules
echo "Clearing existing Cloudflare UFW rules..."
existing_rules=$(sudo ufw status numbered | grep 'Cloudflare' | awk '{print $1}' | tr -d '[]')
for rule in $(echo "$existing_rules" | sort -rn); do
    echo "Deleting rule number $rule"
    yes | sudo ufw delete "$rule"
done

# Function to add UFW rules
add_ufw_rule() {
    local ip="$1"
    local ports="$2"
    echo "Adding UFW rule for $ip on ports $ports"
    sudo ufw allow proto tcp from "$ip" to any port "$ports" comment 'Cloudflare'
}

# Add UFW rules for IPv4 ranges
echo "Adding UFW rules for IPv4 ranges..."
while IFS= read -r ip; do
    add_ufw_rule "$ip" "$ports"
done <<< "$ipv4_ranges"

# Add UFW rules for IPv6 ranges
echo "Adding UFW rules for IPv6 ranges..."
while IFS= read -r ip; do
    add_ufw_rule "$ip" "$ports"
done <<< "$ipv6_ranges"

# Replace the old output file with the new one
mv "$temp_file" "$output_file"

echo "UFW rules added for Cloudflare IP ranges and saved to $output_file."
