#!/bin/bash
# 
# Title:        Sneakernet Micro-NAS
# Description:  Hosts the USB drive contents on a local HTTP file server.
# Author:       James Cupps
# Version:      1.0
# Category:     utility
# Target:       Any
# Net Mode:     BRIDGE
#
# USE CASE: Turn the Squirrel into an instant file server. Load files onto the
#           USB drive, plug the Squirrel inline, and anyone on the network can
#           browse and download files at http://<SQUIRREL_IP>:8000.
#           The IP is saved to /usb/nas_ip.txt for Sneakernet retrieval.

function run_micro_nas() {
    NETMODE BRIDGE
    sleep 10
    LED C SLOW
    
    # Grab the dynamic IP so you know where to point your browser
    IP_ADDR=$(ip addr show br-lan | grep -w inet | awk '{print $2}' | cut -d/ -f1)
    echo "NAS running at http://$IP_ADDR:8000" > /usb/nas_ip.txt

    # Navigate to the USB root and start the Python web server on port 8000
    cd /usb/
    python3 -m http.server 8000 &> /dev/null &
    SERVER_PID=$!
    
    # Indicate the server is live and serving files
    LED C SUCCESS
    
    # Wait for button press to safely spin down the server
    NO_LED=true BUTTON
    kill $SERVER_PID
    LED G SUCCESS
}

USB_WAIT
run_micro_nas &
wait
