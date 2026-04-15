# Broadcast Suppressor

**Category:** OT Security  
**Net Mode:** BRIDGE

## Description

Inline rate-limiter that caps BACnet broadcast traffic to 5 packets per second while passing all other traffic untouched. Protects legacy BACnet controllers from being overwhelmed by broadcast storms from misconfigured or rogue devices.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Setting up firewall rules |
| Solid Cyan | Firewall active — rate limiting enabled |
| Solid Green | Firewall removed — normal traffic restored |

## How It Works

Uses `iptables` with the `limit` module to rate-limit only broadcast packets destined for UDP 47808 (BACnet). All unicast BACnet traffic, established connections, and non-BACnet protocols pass through unrestricted.
