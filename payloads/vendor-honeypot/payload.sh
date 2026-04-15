#!/bin/bash
# 
# Title:        Vendor Honeypot
# Description:  Emulates a vulnerable BMS login page and alerts on connection attempts.
# Author:       James Cupps
# Version:      1.0
# Category:     defense
# Target:       Any
# Net Mode:     BRIDGE
#
# USE CASE: Deploy on a BAS/OT network segment to detect unauthorized scanning
#           or access attempts. Serves a fake BMS controller login page and logs
#           the IP address of anyone who connects.

function run_honeypot() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/honeypot &> /dev/null
    sleep 10

    # Create a fake login page
    echo "<html><body><h1>BMS Controller Login</h1><form><input type='text' name='user'/><input type='password' name='pass'/><input type='submit'/></form></body></html>" > /tmp/index.html

    # Start a Python web server on port 80 in the background
    cd /tmp/
    python3 -m http.server 80 &> /tmp/honeypot_log.txt &
    SERVER_PID=$!

    # Set LED to Yellow (Armed)
    LED SETUP

    # Monitor the python log for incoming connections (runs in background)
    tail -f /tmp/honeypot_log.txt 2>/dev/null | while read log_line; do
        if echo "$log_line" | grep -q "GET"; then
            # Someone tried to connect!
            LED R FAST
            
            # Extract the attacker IP and save it
            ATTACKER_IP=$(echo "$log_line" | awk '{print $1}')
            echo "Attempted access from: $ATTACKER_IP at $(date)" >> /usb/loot/honeypot/alerts.txt
            
            # Stay red for 5 seconds, then re-arm
            sleep 5
            LED SETUP
        fi
    done &
    MONITOR_PID=$!

    # Wait for button press to safely shut down
    NO_LED=true BUTTON
    
    kill $MONITOR_PID 2>/dev/null
    kill $SERVER_PID 2>/dev/null
    LED G SUCCESS
}

USB_WAIT
run_honeypot &
wait
