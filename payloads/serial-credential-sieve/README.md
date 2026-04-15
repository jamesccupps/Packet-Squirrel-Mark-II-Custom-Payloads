# Serial Credential Sieve

**Category:** Pentest  
**Net Mode:** BRIDGE

## Description

Captures plaintext HTTP credentials in real-time and streams them out the hardware UART serial port. Connect a Flipper Zero, laptop with USB-UART adapter, or any serial terminal at 115200 baud to watch credentials appear live.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Purple | Sniffing active |
| Solid Green | Stopped |

## What It Captures

Filters HTTP (port 80) traffic for strings matching `pass=`, `pwd=`, or `login=`. Only works against unencrypted HTTP — HTTPS traffic is invisible.

## Serial Connection

- **Baud rate:** 115200
- **Port:** UART pins on the Packet Squirrel
