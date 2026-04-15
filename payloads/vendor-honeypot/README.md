# Vendor Honeypot

**Category:** Defense  
**Net Mode:** BRIDGE  
**Requires:** USB storage, python3

## Description

Deploys a fake BMS controller login page on port 80 and monitors for connection attempts. Logs the IP address and timestamp of anyone who connects — useful for detecting unauthorized network scanning or access attempts on OT segments.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Armed — honeypot serving |
| Blinking Red (fast) | Connection detected! |
| Solid Green | Shutdown complete |

## Loot Location

```
/usb/loot/honeypot/alerts.txt
```
