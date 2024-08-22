# Block Subnets Script

## Overview
This script blocks a predefined list of subnets using `ufw` (Uncomplicated Firewall) on a Linux system.

## Prerequisites
- This script must be run with root privileges.
- `ufw` must be installed and configured on your system.

## Configuration
1. **Subnets**: Edit the script file `block_subnets.sh` and add the subnets you want to block to the `subnets` array.
   Example:
   ```bash
   subnets=(
     "192.168.1.0/24"
     "10.0.0.0/24"
   )
   ```
2. **Log file**: Ensure the `log_file` path is correctly set. Update the path to where you want to store the logs. For example:
   ```bash
   log_file="/home/youruser/logs/block_subnets.log"
   ```

## Usage
1. Ensure the script has executable permissions:
   ```bash
   chmod +x block_subnets.sh
   ```
2. Run the script as root or using `sudo`:
   ```bash
   sudo ./block_subnets.sh
   ```

## Logs
The script logs its activity in the specified log file. Check the logs for details on blocked subnets or any issues encountered during execution.

## Notes
- Make sure `ufw` is properly configured on your system.
- You can add more subnets to the `subnets` array as needed.
