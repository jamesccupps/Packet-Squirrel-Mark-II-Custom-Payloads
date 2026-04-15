# Packet Capture — Auto (Filtered & Monitored)

**Category:** Sniffing  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Automatic packet capture that starts immediately on boot. Includes BPF filters to exclude noisy background protocols (ARP, SSDP, mDNS, SSH) so you only capture meaningful traffic. Saves the Squirrel's IP to a text file on the USB drive for easy Sneakernet retrieval.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Red | Capturing packets (auto-started) |
| Solid Green | Capture stopped successfully |

## Features

- Auto-starts capture on boot — no button press needed
- BPF filter excludes ARP, SSDP (1900), mDNS (5353), and SSH (22)
- Saves Squirrel IP to `/usb/loot/squirrel_ip.txt`
- USB space monitor kills tcpdump if drive drops below 10MB
- Web UI enabled

## Loot Location

```
/usb/loot/tcpdump/auto_dump_YYYY-MM-DD-HHMMSS.pcap
/usb/loot/squirrel_ip.txt
```
