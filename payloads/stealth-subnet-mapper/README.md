# Stealth Subnet Mapper

**Category:** Recon  
**Net Mode:** BRIDGE  
**Requires:** USB storage, nmap (auto-installed via opkg if missing)

## Description

Performs a fast, stealthy ping sweep of the local subnet using Nmap with MAC spoofing and decoy IPs. Uses a smart polling loop (no fixed `sleep 10`) to get an IP as fast as possible, writes scan results to RAM first for speed, then flushes to USB.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Waiting for IP address |
| Blinking Red | Scanning |
| Solid Green | Scan complete |
| Blinking Red (FAIL) | Failed to get IP or subnet |

## Features

- Smart IP wait: polls every 2s for up to 30s (no wasted time)
- RAM-cached scan output for speed, then moved to USB
- Nmap `-T4` aggressive timing
- MAC spoofing (Cisco) + 5 random decoy IPs
- Randomized host order to evade sequential detection

## Loot Location

```
/usb/loot/nmap/hybrid_scan_YYYY-MM-DD-HHMMSS.txt
/usb/loot/squirrel_ip.txt
```
