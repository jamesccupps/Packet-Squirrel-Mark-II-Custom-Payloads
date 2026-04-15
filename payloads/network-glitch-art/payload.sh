#!/bin/bash
# 
# Title:        Network Glitch Art
# Description:  Intentionally corrupts 1% of network traffic to generate digital art.
# Author:       James Cupps
# Version:      1.0
# Category:     chaos
# Target:       Any
# Net Mode:     BRIDGE
#
# HOW IT WORKS: Uses Linux Traffic Control (tc) to flip random bits in 1% of
#               packets passing through the bridge. When downloading unencrypted
#               media (HTTP images, UDP video streams), the receiving end renders
#               the corrupted bytes as beautiful, unpredictable visual glitches.
#
# NOTE: HTTPS traffic is immune — corrupted TLS packets are dropped and
#       re-requested. Best results on HTTP sites, LAN games, or raw UDP streams.
#
# REQUIRES:     tc / iproute2 (will attempt auto-install via opkg)

# Install tc if not present
if ! which tc &>/dev/null; then
    opkg update &>/dev/null && opkg install tc-full &>/dev/null
    if ! which tc &>/dev/null; then
        LED FAIL
        exit 1
    fi
fi

function run_glitch_art() {
    NETMODE BRIDGE
    sleep 10
    
    # Indicate armed state
    LED SETUP
    
    # Wait for the button press to start the glitching
    NO_LED=true BUTTON
    
    # Indicate the art generator is active (Blinking Purple)
    LED M FAST
    
    # Flush any existing traffic control rules on the bridge
    tc qdisc del dev br-lan root 2>/dev/null
    
    # Introduce exactly 1% packet corruption
    tc qdisc add dev br-lan root netem corrupt 1%
    
    # Wait for the second button press to stop
    NO_LED=true BUTTON
    
    # Clean up the rules to restore normal internet
    tc qdisc del dev br-lan root 2>/dev/null
    LED G SUCCESS
}

run_glitch_art &
wait
