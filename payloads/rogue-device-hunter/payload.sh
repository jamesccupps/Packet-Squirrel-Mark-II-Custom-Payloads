#!/bin/bash
# 
# Title:        Rogue Device Hunter
# Description:  Builds a MAC address whitelist, then alerts on any new device that appears.
# Author:       James Cupps
# Version:      1.0
# Category:     defense
# Target:       Any
# Net Mode:     BRIDGE
#
# HOW IT WORKS:
# Phase 1 (5 minutes): Learns all MAC addresses on the network as "known good"
# Phase 2 (ongoing):   Alerts and logs any MAC address not in the baseline

function run_hunter() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/rogue &> /dev/null
    BASELINE="/tmp/baseline_macs.txt"
    sleep 10
    
    LED SETUP
    # Step 1: Baseline for 5 minutes (300 seconds)
    timeout 300 tcpdump -i br-lan -e -n -l 2>/dev/null | awk '{print $2}' | grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | sort | uniq > "$BASELINE"
    
    LED ATTACK
    # Step 2: Hunt Mode
    tcpdump -i br-lan -e -n -l 2>/dev/null | awk '{print $2}' | grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | while read MAC; do
        if ! grep -q "$MAC" "$BASELINE"; then
            # NEW MAC FOUND! Flash Red and log it
            LED R FAST
            echo "Rogue MAC Detected: $MAC at $(date)" >> /usb/loot/rogue/alerts.txt
            sleep 2
            LED ATTACK
        fi
    done
}

USB_WAIT
run_hunter &
wait
