# OT Traffic Visualizer

**Category:** OT Security  
**Net Mode:** BRIDGE

## Description

Screenless LED-based traffic monitor for OT/BAS networks. The Squirrel's LED changes color in real-time based on what protocols it sees passing through, giving you instant visual feedback without needing a laptop.

## LED Color Key

| LED | Meaning |
|-----|---------|
| Solid Green | Idle / Normal |
| Blinking Blue | BACnet traffic (UDP 47808) |
| Blinking Purple | Modbus traffic (TCP 502) |
| Solid Red | ARP flood detected |

## Use Cases

- Quick visual health check of a BAS network segment
- Verify a controller is actively communicating
- Spot ARP storms from misconfigured devices
