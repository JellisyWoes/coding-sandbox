# Cloudflare UFW Updater

## Description

This script automates the process of updating UFW (Uncomplicated Firewall) rules based on the latest Cloudflare IP ranges. It fetches both IPv4 and IPv6 Cloudflare IP ranges, compares them with previously stored ranges, and updates the UFW rules only if changes are detected. The script also clears outdated rules before applying new ones, ensuring that only Cloudflare's current IPs have access to specified ports.

## Features

- Fetches Cloudflare IP ranges (IPv4 and IPv6).
- Dynamically opens ports for Cloudflare IPs via UFW.
- Compares new IP ranges with previously saved ranges to avoid redundant rule updates.
- Clears old Cloudflare-specific UFW rules before applying new ones.
- Easily configurable port selection.
- Logs changes and applied rules to a file (`cloudflare_ufw_rules.txt`).

## Prerequisites

Before using the script, make sure you have the following:

1. **UFW (Uncomplicated Firewall)** installed and enabled on your system:
    ```bash
    sudo apt install ufw
    sudo ufw enable
    ```

2. **Curl** installed:
    ```bash
    sudo apt install curl
    ```

3. **Sudo permissions** to modify UFW rules.

## Usage

### 1. Clone or download the repository

```bash
git clone <repository_url>
cd cloudflare-ufw-updater
```

### 2. Make the script executable

```bash
chmod +x cloudflare_ufw_updater.sh
```

### 3. Configure ports

Before running the script, you can specify which ports Cloudflare IPs will be allowed to access. Edit the `ports` variable in the script to your desired ports:

```bash
ports="YOUR_PORTS_HERE"
```

For example, to open ports `80`, `443`, and `8080`, you would set it as:

```bash
ports="80,443,8080"
```

### 4. Run the script

```bash
./cloudflare_ufw_updater.sh
```

The script will:
- Fetch the latest Cloudflare IP ranges for both IPv4 and IPv6.
- Compare them with any previously fetched ranges (stored in `cloudflare_ufw_rules.txt`).
- Update UFW rules if changes are detected.
- Clear old Cloudflare-related UFW rules before applying the new ones.

### 5. Automate with a Cron Job (Optional)

To automate running the script periodically (e.g., weekly), you can create a cron job:

1. Open the crontab file:
    ```bash
    crontab -e
    ```

2. Add an entry to run the script weekly (example below runs every Monday at 3 AM):
    ```bash
    0 3 * * 1 /path/to/cloudflare_ufw_updater.sh
    ```

## Output

- The script creates and updates a file named `cloudflare_ufw_rules.txt`. This file contains:
  - A timestamp when the IP ranges were last fetched.
  - The ports opened for Cloudflare IPs.
  - The list of Cloudflare IP ranges (both IPv4 and IPv6).

### Example of the file's content:

```
Timestamp: Tue Aug 22 10:00:00 UTC 2024
Ports: 80,443,8080
IPv4:
173.245.48.0/20
103.21.244.0/22
...
IPv6:
2400:cb00::/32
2606:4700::/32
...
```

## Customization

- **Ports:** Update the `ports` variable in the script to specify the ports you need.
- **File locations:** You can customize where the script saves the IP ranges log (`cloudflare_ufw_rules.txt`).
- **Cron schedule:** Adjust the cron job schedule to fit your update frequency needs.

## License

This script is licensed under the MIT License. You are free to use, modify, and distribute the script as needed.
