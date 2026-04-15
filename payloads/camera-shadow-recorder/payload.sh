#!/bin/bash
# 
# Title:        Camera Shadow Recorder
# Description:  Silently captures RTSP video streams to the USB drive as a backup.
# Author:       James Cupps
# Version:      1.0
# Category:     sniffing
# Target:       IP Cameras
# Net Mode:     BRIDGE
#
# USE CASE: Drop inline with a high-value PoE security camera. The camera still
#           sends video to the NVR normally, but the Squirrel silently captures
#           the raw RTSP stream to USB as a decentralized backup. Rotates files
#           every hour to prevent corruption from large captures.

function run_shadow_record() {
    NETMODE BRIDGE
    mkdir -p /usb/loot/video_backup &> /dev/null
    sleep 5
    
    LED ATTACK
    
    # Filter for RTSP (Real-Time Streaming Protocol) on port 554
    # -G 3600 rotates the capture file every 1 hour
    tcpdump -i br-lan -s 0 tcp port 554 -G 3600 -w '/usb/loot/video_backup/camera_%Y-%m-%d_%H%M.pcap' &>/dev/null &
    tpid=$!
    
    NO_LED=true BUTTON
    kill $tpid
    sync
    LED G SUCCESS
}

USB_WAIT
run_shadow_record &
wait
