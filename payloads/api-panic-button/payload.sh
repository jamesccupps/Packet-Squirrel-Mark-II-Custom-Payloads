#!/bin/bash
# 
# Title:        API Panic Button
# Description:  Fires a Home Assistant webhook on each button press. Loops indefinitely.
# Author:       James Cupps
# Version:      1.0
# Category:     home-automation
# Target:       Any
# Net Mode:     BRIDGE
#
# SETUP: Replace HA_WEBHOOK below with your Home Assistant IP and webhook ID.
#        Create an automation in HA that triggers on this webhook to do whatever
#        you want: flash lights, lock doors, send notifications, etc.

# Define your local Home Assistant webhook URL here
HA_WEBHOOK="http://192.168.1.XXX:8123/api/webhook/your_secret_webhook_id"

function run_api_button() {
    NETMODE BRIDGE
    sleep 10
    
    # Loop: wait in armed state, fire webhook on press, repeat
    while true; do
        LED SETUP
        
        # Wait for the user to physically push the button
        NO_LED=true BUTTON
        LED ATTACK
        
        # Fire the webhook payload
        wget --post-data='{"source": "packet_squirrel", "action": "panic_button_pressed"}' --header="Content-Type: application/json" -q -O /dev/null "$HA_WEBHOOK" 2>/dev/null
        
        # Flash success and reset for the next press
        LED G SUCCESS
        sleep 2
    done
}

run_api_button &
wait
