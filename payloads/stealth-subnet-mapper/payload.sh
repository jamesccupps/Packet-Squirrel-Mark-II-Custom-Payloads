#!/bin/bash
# 
# Title:        Stealth Subnet Mapper
# Description:  Smart-wait for IP, RAM caching, and speed-optimized stealth Nmap sweep.
# Author:       James Cupps (based on Hak5 examples)
# Version:      1.0
# Category:     recon
# Target:       Any
# Net Mode:     BRIDGE
#
# REQUIRES:     nmap (will attempt auto-install via opkg)

# Install nmap if not present
if ! which nmap &>/dev/null; then
    opkg update &>/dev/null && opkg install nmap &>/dev/null
    if ! which nmap &>/dev/null; then
        LED FAIL
        exit 1
    fi
fi

function run_mapper() {
    # 1. Set mode to BRIDGE
    NETMODE BRIDGE
    
    # Indicate we are waiting for an IP (Blinking Yellow)
    LED SETUP
    
    # 2. "Smart Wait" for an IP address
    # Polls the interface every 2 seconds, up to 15 times (30 seconds max)
    for i in {1..15}; do
        IP_ADDR=$(ip addr show br-lan | grep -w inet | awk '{print $2}' | cut -d/ -f1)
        if [ ! -z "$IP_ADDR" ]; then
            break
        fi
        sleep 2
    done

    # If we STILL don't have an IP, abort safely
    if [ -z "$IP_ADDR" ]; then
        LED FAIL
        exit 1
    fi

    # 3. Setup the loot directory and log the IP for Sneakernet access
    mkdir -p /usb/loot/nmap &> /dev/null
    echo "$IP_ADDR" > /usb/loot/squirrel_ip.txt

    # 4. Dynamically figure out the local subnet
    SUBNET=$(ip route | grep br-lan | grep -v default | awk '{print $1}')

    # 5. Execute the scan
    if [ ! -z "$SUBNET" ]; then
        # Indicate active scanning (Solid Red)
        LED ATTACK
        
        # Write to RAM first for speed, then move to USB
        TMP_FILE="/tmp/hybrid_scan.txt"
        FINAL_FILE="/usb/loot/nmap/hybrid_scan_$(date +%Y-%m-%d-%H%M%S).txt"
        
        # -T4 for aggressive timing, MAC spoofing + decoys for stealth
        nmap -sn "$SUBNET" -T4 --spoof-mac Cisco -D RND:5 --randomize-hosts -oN "$TMP_FILE" &> /dev/null
        
        # Move from RAM to permanent USB storage
        mv "$TMP_FILE" "$FINAL_FILE"
        sync
        
        # Scan complete (Solid Green)
        LED G SUCCESS
    else
        LED FAIL
    fi
}

# Wait for the USB drive to mount
USB_WAIT

# Start the routine
run_mapper &
wait
