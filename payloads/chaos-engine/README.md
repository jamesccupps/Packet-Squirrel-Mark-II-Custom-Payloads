# Chaos Engine (Lag Switch)

**Category:** Chaos  
**Net Mode:** BRIDGE  
**Requires:** tc / iproute2 (auto-installed via opkg if missing)

## Description

Injects 250ms base delay with +/- 50ms random jitter into all traffic passing through the bridge. Turns any internet connection into a miserable, laggy mess. Useful for latency tolerance testing or LAN party pranks.

## LED States

| LED | Meaning |
|-----|---------|
| Solid Red | Chaos active |

## Stopping

Power cycle the Squirrel to restore normal traffic. There is no button stop — this is intentional.

## Parameters

- **Base delay:** 250ms
- **Jitter:** +/- 50ms random
