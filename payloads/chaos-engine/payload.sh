#!/bin/bash
# 
# Title:        Chaos Engine (Lag Switch)
# Description:  Injects 250ms delay with random jitter into the connection.
# Author:       James Cupps
# Version:      1.0
# Category:     chaos
# Target:       Any
# Net Mode:     BRIDGE
#
# WARNING: This makes the internet TERRIBLE for whoever is plugged in.
#          250ms base delay + random 50ms jitter. Great for latency testing
#          or LAN party pranks. Power cycle the Squirrel to stop.
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

function run_chaos() {
    NETMODE BRIDGE
    sleep 10
    
    # Clear existing rules
    tc qdisc del dev br-lan root 2>/dev/null
    
    # Inject a 250ms delay, with a random +/- 50ms jitter
    tc qdisc add dev br-lan root netem delay 250ms 50ms
    
    # Solid Red LED so you know the chaos is active
    LED R SOLID
}

run_chaos &
wait
