#!/bin/bash
# 
# Title:        OT Traffic Visualizer
# Description:  Screenless LED monitor for BACnet, Modbus, and broadcast activity.
# Author:       James Cupps
# Version:      1.0
# Category:     ot-security
# Target:       BAS/OT Networks
# Net Mode:     BRIDGE
#
# LED COLOR KEY:
#   Green  = Idle / Normal
#   Blue   = BACnet traffic (UDP 47808)
#   Purple = Modbus traffic (TCP 502)
#   Red    = ARP flood detected

function run_visualizer() {
    NETMODE BRIDGE
    sleep 10
    
    # Start with a baseline Green (All Good)
    LED G SUCCESS

    # Read tcpdump output line by line
    tcpdump -i br-lan -l -n 2>/dev/null | while read line; do
        
        # Check for BACnet (UDP 47808)
        if echo "$line" | grep -q "47808"; then
            LED B FAST
            sleep 1
            LED G SUCCESS
            
        # Check for Modbus (TCP 502)
        elif echo "$line" | grep -q "\.502 >\|> .*\.502"; then
            LED M FAST
            sleep 1
            LED G SUCCESS
            
        # Check for ARP request floods
        elif echo "$line" | grep -q "ARP, Request who-has"; then
            LED R SOLID
            sleep 1
            LED G SUCCESS
        fi
    done
}

run_visualizer &
wait
