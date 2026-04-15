# BMS Watchdog

**Category:** OT Security  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Silently captures only BACnet (UDP 47808) and Modbus TCP (port 502) traffic. Designed for inline deployment on BAS/OT network segments to audit building automation traffic without disrupting operations.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Setup / waiting for IP |
| Blinking Red | Capturing BMS traffic |
| Solid Green | Capture stopped |

## Use Cases

- Verify HVAC controller communications
- Audit BACnet Who-Is/I-Am discovery traffic
- Hunt for unauthorized Modbus read/write commands
- Document OT traffic patterns for security assessments

## Loot Location

```
/usb/loot/bms/hvac_audit_YYYYMMDD_HHMM.pcap
/usb/loot/squirrel_ip.txt
```
