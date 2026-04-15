#!/bin/bash
# 
# Title:        Hotel Stealth NAT
# Description:  Clones your MAC address and acts as a router for multiple devices.
# Author:       James Cupps
# Version:      1.0
# Category:     utility
# Target:       Any
# Net Mode:     NAT
#
# USE CASE: Hotel/resort networks that limit connections to one device per room.
#           Authenticate once with your laptop, press the button, and the Squirrel
#           clones your MAC and becomes a NAT router. Plug a travel switch or AP
#           into it and all your devices share the single approved connection.
#
# REQUIRES:     macchanger (will attempt auto-install via opkg)

# Install macchanger if not present
if ! which macchanger &>/dev/null; then
    opkg update &>/dev/null && opkg install macchanger &>/dev/null
    if ! which macchanger &>/dev/null; then
        LED FAIL
        exit 1
    fi
fi

function run_hotel_nat() {
    # Start in NAT mode (Squirrel acts as a router)
    NETMODE NAT
    sleep 10
    LED SETUP

    # Wait for button press to capture your laptop's MAC address and clone it
    NO_LED=true BUTTON
    LED SPECIAL
    
    # Grab the MAC address of the device plugged into the Squirrel's LAN port
    CLIENT_MAC=$(ip neigh show dev eth1 | awk '{print $5}' | head -n 1)
    
    if [ ! -z "$CLIENT_MAC" ]; then
        # Take the WAN interface down, spoof the MAC, and bring it back up
        ifconfig eth0 down
        macchanger -m "$CLIENT_MAC" eth0
        ifconfig eth0 up
        
        # Success - Plug a switch or AP in and share the connection
        LED G SUCCESS
    else
        # Failed to find a client MAC
        LED FAIL
    fi
}

run_hotel_nat &
wait
