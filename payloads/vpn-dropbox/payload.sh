#!/bin/bash
# 
# Title:        VPN Drop Box
# Description:  Bridges the connection and automatically establishes an OpenVPN tunnel.
# Author:       James Cupps
# Version:      1.0
# Category:     remote-access
# Target:       Any
# Net Mode:     BRIDGE
#
# SETUP: Place your OpenVPN config file on the USB drive as /usb/dropbox.ovpn
#        before deploying this payload.

function run_tunnel() {
    NETMODE BRIDGE
    
    # Indicate we are waiting for internet (Blinking Cyan)
    LED C SLOW
    
    # Wait until the Squirrel can actually reach the internet
    while ! ping -c 1 -W 1 8.8.8.8 &> /dev/null; do
        sleep 2
    done

    # Indicate connection attempt (Blinking Yellow)
    LED SETUP

    # Check if the VPN config file exists on the USB
    if [ -f "/usb/dropbox.ovpn" ]; then
        # Start OpenVPN in the background using the config file
        openvpn --config /usb/dropbox.ovpn --daemon
        
        # Give it time to establish the handshake
        sleep 10
        
        # If the tunnel interface (tun0) is up, show success
        if ip link show tun0 &> /dev/null; then
            # Connected and tunneled! (Solid Cyan)
            LED C SUCCESS
        else
            # VPN failed to connect (Solid Red)
            LED R SUCCESS
        fi
    else
        # Config file not found on USB (Blinking Red)
        LED FAIL
    fi
}

USB_WAIT
run_tunnel &
wait
