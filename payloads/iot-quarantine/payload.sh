#!/bin/bash
# 
# Title:        IoT Quarantine
# Description:  Physical firewall that allows local LAN traffic but blocks all internet access.
# Author:       James Cupps
# Version:      1.0
# Category:     defense
# Target:       Any
# Net Mode:     BRIDGE
#
# USE CASE: Cheap smart-home devices (cameras, plugs, 3D printers) that phone
#           home to overseas cloud servers. Drop the Squirrel inline and the device
#           can still talk locally (e.g., to Home Assistant) but is physically
#           blocked from reaching the internet.

function run_quarantine() {
    NETMODE BRIDGE
    sleep 5
    LED SETUP

    # Flush existing firewall rules
    iptables -F FORWARD

    # Allow local traffic (all RFC1918 private ranges)
    iptables -A FORWARD -d 192.168.0.0/16 -j ACCEPT
    iptables -A FORWARD -d 10.0.0.0/8 -j ACCEPT
    iptables -A FORWARD -d 172.16.0.0/12 -j ACCEPT

    # Drop everything else (internet traffic)
    iptables -A FORWARD -j DROP

    # Cyan LED indicates the quarantine firewall is active
    LED C SUCCESS
    
    # Button press to lift the quarantine
    NO_LED=true BUTTON
    iptables -F FORWARD
    LED G SUCCESS
}

run_quarantine &
wait
