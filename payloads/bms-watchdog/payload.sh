#!/bin/bash
# 
# Title:        BMS Watchdog
# Description:  Silently captures only BACnet (UDP 47808) and Modbus (TCP 502) traffic.
# Author:       James Cupps
# Version:      1.0
# Category:     ot-security
# Target:       BAS/BMS Networks
# Net Mode:     BRIDGE
#
# USE CASE: Drop inline on an OT/BAS network segment to audit BACnet and Modbus
#           traffic without disrupting building automation systems. Ideal for
#           verifying HVAC controller communications or hunting for unauthorized
#           BACnet commands.

function run_bms_watchdog() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/bms &> /dev/null
    
    # Smart wait for IP
    for i in {1..15}; do
        IP_ADDR=$(ip addr show br-lan | grep -w inet | awk '{print $2}')
        [[ ! -z "$IP_ADDR" ]] && break
        sleep 2
    done

    # Save IP for Sneakernet retrieval
    echo "$IP_ADDR" > /usb/loot/squirrel_ip.txt
    
    LED SETUP
    
    # BPF Filter strictly for BMS protocols
    BMS_FILTER="udp port 47808 or tcp port 502"
    
    LED ATTACK
    # Run the capture
    tcpdump -i br-lan -s 0 "$BMS_FILTER" -w /usb/loot/bms/hvac_audit_$(date +%Y%m%d_%H%M).pcap &>/dev/null &
    tpid=$!
    
    # Wait for button press to safely stop
    NO_LED=true BUTTON
    kill $tpid
    sync
    LED G SUCCESS
}

USB_WAIT
run_bms_watchdog &
wait
