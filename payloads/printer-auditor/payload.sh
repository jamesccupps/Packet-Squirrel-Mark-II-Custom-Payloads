#!/bin/bash
# 
# Title:        Printer Auditor
# Description:  Monitors local MQTT/FTP traffic and flags outbound cloud phone-home attempts.
# Author:       James Cupps
# Version:      1.0
# Category:     defense
# Target:       3D Printers / IoT Printers
# Net Mode:     BRIDGE
#
# USE CASE: Modern networked printers (especially 3D printers like Bambu Lab)
#           communicate via MQTT and FTP locally, but may also phone home to
#           cloud servers. This payload captures local protocol traffic while
#           simultaneously monitoring DNS for rogue cloud connection attempts.

function run_printer_auditor() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/printer &> /dev/null
    sleep 10
    LED SETUP

    # Capture MQTT-TLS (8883) and FTP (21, 990)
    tcpdump -i br-lan "tcp port 8883 or port 21 or port 990" -w /usb/loot/printer/gcode_traffic.pcap &>/dev/null &
    
    # Simultaneously monitor for rogue DNS requests to cloud servers
    tcpdump -l -i br-lan udp port 53 2>/dev/null | grep --line-buffered "bambulab\|cloud" > /usb/loot/printer/rogue_dns_alerts.txt &
    
    NO_LED=true BUTTON
    killall tcpdump
    sync
    LED G SUCCESS
}

USB_WAIT
run_printer_auditor &
wait
