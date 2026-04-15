#!/bin/bash
# 
# Title:        Entropy Harvester
# Description:  Converts network noise into cryptographic randomness via SHA-256.
# Author:       James Cupps
# Version:      1.0
# Category:     utility
# Target:       Any
# Net Mode:     BRIDGE
#
# HOW IT WORKS: Captures raw network traffic, pipes each chunk through SHA-256,
#               and appends the hash to a file. The result is high-quality
#               randomness derived from real-world network entropy — packet timing,
#               payload content, source addresses, etc.

function run_entropy() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/entropy &> /dev/null
    sleep 10
    
    LED ATTACK
    
    # Capture traffic line by line and hash each line through SHA-256
    tcpdump -i br-lan -l -n 2>/dev/null | while read line; do
        echo "$line" | sha256sum | awk '{print $1}'
    done >> /usb/loot/entropy/true_random.txt &
    tpid=$!
    
    # Wait for button press to stop harvesting
    NO_LED=true BUTTON
    kill $tpid
    sync
    LED G SUCCESS
}

USB_WAIT
run_entropy &
wait
