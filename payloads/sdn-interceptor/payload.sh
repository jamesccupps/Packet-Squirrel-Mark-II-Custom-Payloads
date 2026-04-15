#!/bin/bash
# 
# Title:        SDN Interceptor
# Description:  Sniffs UniFi STUN and Inform packets to map SDN infrastructure.
# Author:       James Cupps
# Version:      1.0
# Category:     recon
# Target:       UniFi / SDN Networks
# Net Mode:     BRIDGE
#
# CAPTURED PROTOCOLS:
#   TCP 8080 = UniFi Inform (device-to-controller adoption/config)
#   UDP 3478 = STUN (NAT traversal / connectivity checks)

function run_sdn_sniff() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/sdn_map &> /dev/null
    sleep 5
    
    LED SETUP

    # Filter for UniFi Inform (TCP 8080) and STUN (UDP 3478)
    tcpdump -i br-lan -s 0 "tcp port 8080 or udp port 3478" -w /usb/loot/sdn_map/unifi_telemetry_$(date +%Y%m%d).pcap &>/dev/null &
    tpid=$!
    
    NO_LED=true BUTTON
    kill $tpid
    sync
    LED G SUCCESS
}

USB_WAIT
run_sdn_sniff &
wait
