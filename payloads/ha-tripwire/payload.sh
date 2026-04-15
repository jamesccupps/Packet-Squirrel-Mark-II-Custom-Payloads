#!/bin/bash
# 
# Title:        HA Tripwire
# Description:  Monitors packet rate and fires a Home Assistant webhook on anomaly detection.
# Author:       James Cupps
# Version:      1.0
# Category:     defense
# Target:       Any
# Net Mode:     BRIDGE
#
# SETUP: Replace HA_URL below with your Home Assistant IP and webhook ID.
#        Create the webhook automation in HA to trigger notifications,
#        alarms, or other actions when an anomaly is detected.

# Replace with your Home Assistant local IP and Webhook ID
HA_URL="http://192.168.1.XX:8123/api/webhook/your_custom_webhook_id"

function run_tripwire() {
    NETMODE BRIDGE
    sleep 10
    LED SETUP

    # Monitor loop
    while true; do
        # Count packets over 5 seconds
        PKT_COUNT=$(timeout 5 tcpdump -i br-lan -c 500 -n 2>/dev/null | wc -l)
        
        # If we see more than 400 packets in 5 seconds (broadcast storm / Nmap scan)
        if [ "$PKT_COUNT" -gt 400 ]; then
            LED R FAST
            # Fire the webhook to Home Assistant
            wget --post-data='{"alert":"Network Anomaly Detected"}' --header="Content-Type: application/json" -q -O /dev/null "$HA_URL" 2>/dev/null
            # Cooldown for 60 seconds so we don't spam notifications
            sleep 60 
            LED SETUP
        fi
    done
}

run_tripwire &
wait
