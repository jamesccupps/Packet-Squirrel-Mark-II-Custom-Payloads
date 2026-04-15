# IoT Quarantine

**Category:** Defense  
**Net Mode:** BRIDGE

## Description

Physical firewall that allows local LAN traffic but blocks all internet access. Drop the Squirrel inline between a sketchy IoT device and your network — the device can still talk to local services (Home Assistant, NAS, etc.) but is physically unable to reach the internet.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Setting up firewall |
| Solid Cyan | Quarantine active |
| Solid Green | Quarantine lifted |

## Blocked / Allowed

- **Allowed:** All RFC1918 private ranges (192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12)
- **Blocked:** Everything else (all internet-bound traffic)
