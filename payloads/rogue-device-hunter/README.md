# Rogue Device Hunter

**Category:** Defense  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Two-phase network monitor. Phase 1 learns all MAC addresses on the network over 5 minutes as a "known good" baseline. Phase 2 runs indefinitely, flashing red and logging any new MAC address that wasn't in the baseline.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Phase 1 — Learning baseline (5 minutes) |
| Blinking Red | Phase 2 — Hunting for rogues |
| Blinking Red (fast) | Rogue device detected! |

## Loot Location

```
/usb/loot/rogue/alerts.txt
```

Each alert includes the MAC address and timestamp.
