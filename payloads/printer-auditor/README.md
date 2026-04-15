# Printer Auditor

**Category:** Defense  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Dual-purpose monitor for networked printers (especially 3D printers like Bambu Lab). Captures local MQTT-TLS and FTP traffic while simultaneously monitoring DNS queries for cloud phone-home attempts. Produces both a traffic PCAP and a separate alert log.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Setup |
| Solid Green | Stopped |

## Loot Location

```
/usb/loot/printer/gcode_traffic.pcap      # MQTT + FTP capture
/usb/loot/printer/rogue_dns_alerts.txt     # Cloud phone-home attempts
```
