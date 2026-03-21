#!/bin/bash
# 
# Title:        Auto-Dump (Filtered & Monitored)
# Description:  Auto-starts in BRIDGE mode. Logs IP to USB. Excludes noisy protocols. Press button to stop.
# Author:       Hak5 / Modified
# Version:      4.0
# Category:     sniffing
# Target:       Any
# Net Mode:     BRIDGE

# ============================================================================
# EXFILTRATION & ACCESS NOTES
# ============================================================================
# HOW TO FIND THE SQUIRREL'S IP:
# The IP is automatically saved to: /usb/loot/squirrel_ip.txt
#
# EXFIL OPTION 1: PYTHON WEB SERVER (Browser Download)
# 1. SSH into the Squirrel: ssh root@<SQUIRREL_IP>
# 2. Run: cd /usb/loot/tcpdump/
# 3. Run: python3 -m http.server 8080
# 4. Open a web browser to http://<SQUIRREL_IP>:8080
#
# EXFIL OPTION 2: SCP (Terminal Download)
# 1. Run: scp -r root@<SQUIRREL_IP>:/usb/loot/tcpdump/ .
# ============================================================================

function monitor_space() {
    # Safely monitors USB space and kills tcpdump if it drops below 10MB [cite: 2]
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
    # Kill TCPDump and sync filesystem [cite: 2]
    kill $1
    wait $1 2>/dev/null
    sync

    # Indicate successful capture stop [cite: 2]
    LED G SUCCESS
}

function run() {
    # 1. Set networking to BRIDGE mode [cite: 2]
    NETMODE BRIDGE
    sleep 5

    # 2. Create loot directory [cite: 2]
    mkdir -p /usb/loot/tcpdump &> /dev/null

    # 3. Log the dynamically assigned IP to the USB drive
    ip addr show br-lan | grep -w inet | awk '{print $2}' | cut -d/ -f1 > /usb/loot/squirrel_ip.txt

    # 4. Activate the Web UI
    UI_START

    # 5. Define BPF Filters to ignore background noise
    # Excludes: ARP, SSDP (port 1900), mDNS (port 5353), and SSH (port 22)
    BPF_FILTER="not arp and not udp port 1900 and not udp port 5353 and not port 22"

    # Indicate active packet capture [cite: 2]
    LED ATTACK
    
    # 6. Auto-start tcpdump with filters [cite: 2]
    tcpdump -i br-lan -s 0 "$BPF_FILTER" -w /usb/loot/tcpdump/auto_dump_$(date +%Y-%m-%d-%H%M%S).pcap &>/dev/null &
    tpid=$!
    
    # Monitor USB space in the background
    monitor_space $tpid &
    monitor_pid=$!

    # 7. Wait for button press to safely STOP the capture 
    NO_LED=true BUTTON
    
    # Stop the space monitor and finish the capture 
    kill $monitor_pid 2>/dev/null
    finish $tpid
}

# Wait for the USB drive 
USB_WAIT

# Start the main routine 
run &

wait
