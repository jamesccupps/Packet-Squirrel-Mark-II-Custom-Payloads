# SDN Interceptor

**Category:** Recon  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Captures UniFi STUN and Inform packets to map SDN infrastructure. Useful for understanding how UniFi devices communicate with their controller, or for auditing adoption and configuration traffic on managed networks.

## Captured Protocols

| Port | Protocol | Purpose |
|------|----------|---------|
| TCP 8080 | UniFi Inform | Device-to-controller adoption and config |
| UDP 3478 | STUN | NAT traversal and connectivity checks |

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Setup |
| Solid Green | Stopped |

## Loot Location

```
/usb/loot/sdn_map/unifi_telemetry_YYYYMMDD.pcap
```
