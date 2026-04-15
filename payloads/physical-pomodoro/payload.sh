#!/bin/bash
# 
# Title:        Physical Pomodoro
# Description:  Hardware-level distraction blocker for 25-minute focus sprints.
# Author:       James Cupps
# Version:      1.0
# Category:     utility
# Target:       Any
# Net Mode:     BRIDGE
#
# HOW IT WORKS: Press the button to start a 25-minute focus sprint. The Squirrel
#               blocks Reddit, YouTube, Twitter, and Facebook at the network level.
#               After 25 minutes, the blocks lift for a 5-minute break, then it
#               resets and waits for the next button press.
#
# LED KEY:
#   Yellow = Ready (press button to start)
#   Red    = Focus mode active (sites blocked)
#   Green  = Break time (sites unblocked)

function run_pomodoro() {
    NETMODE BRIDGE
    sleep 10
    
    while true; do
        # Ready state
        LED SETUP
        
        # Wait for user to push the button to start the focus sprint
        NO_LED=true BUTTON
        
        # Focus Mode Active (Solid Red)
        LED R SOLID
        
        # Block distracting sites via iptables string matching
        iptables -I FORWARD -m string --algo bm --string "reddit.com" -j DROP
        iptables -I FORWARD -m string --algo bm --string "youtube.com" -j DROP
        iptables -I FORWARD -m string --algo bm --string "twitter.com" -j DROP
        iptables -I FORWARD -m string --algo bm --string "facebook.com" -j DROP
        
        # 25 minute focus sprint (1500 seconds)
        sleep 1500
        
        # Break Time! (Solid Green)
        LED G SUCCESS
        
        # Remove the blocks
        iptables -F FORWARD
        
        # 5 minute break (300 seconds) before resetting
        sleep 300
    done
}

run_pomodoro &
wait
