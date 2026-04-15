#!/bin/bash
# 
# Title:        Broadcast Suppressor
# Description:  Rate-limits BACnet broadcasts to protect legacy OT networks.
# Author:       James Cupps
# Version:      1.0
# Category:     ot-security
# Target:       BAS/OT Networks
# Net Mode:     BRIDGE
#
# USE CASE: Legacy BACnet controllers can be overwhelmed by broadcast storms
#           from misconfigured or rogue devices. This payload acts as an inline
#           rate-limiter, capping BACnet broadcasts to 5/sec while passing all
#           other traffic untouched.

function run_suppressor() {
    NETMODE BRIDGE
    sleep 10

    LED SETUP

    # Flush any existing rules
    iptables -F FORWARD

    # Allow all established, unicast, and normal traffic
    iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    
    # Limit BACnet (UDP 47808) broadcasts to 5 per second
    iptables -A FORWARD -p udp --dport 47808 -m pkttype --pkt-type broadcast -m limit --limit 5/sec -j ACCEPT
    
    # Drop any BACnet broadcasts that exceed that limit
    iptables -A FORWARD -p udp --dport 47808 -m pkttype --pkt-type broadcast -j DROP

    # Allow everything else to pass through the bridge
    iptables -A FORWARD -j ACCEPT

    # Cyan LED indicates the firewall is active and bridging
    LED C SUCCESS
    
    # Wait for button press to clear the firewall rules and stop
    NO_LED=true BUTTON
    iptables -F FORWARD
    LED G SUCCESS
}

run_suppressor &
wait
