# Network Glitch Art

**Category:** Chaos  
**Net Mode:** BRIDGE  
**Requires:** tc / iproute2 (auto-installed via opkg if missing)

## Description

Uses Linux Traffic Control (`tc`) to introduce 1% packet corruption through the bridge. When downloading unencrypted media (HTTP images, UDP video streams, LAN game traffic), the receiving end renders corrupted bytes as unpredictable visual glitches.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Armed — press button to start |
| Blinking Purple (fast) | Glitch generator active |
| Solid Green | Stopped — normal traffic restored |

## Notes

- HTTPS traffic is immune — corrupted TLS packets are dropped and re-requested
- Best results on HTTP sites, LAN games, or raw UDP streams
- Button press to start, button press to stop
