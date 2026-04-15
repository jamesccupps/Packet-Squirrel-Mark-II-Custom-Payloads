# Entropy Harvester

**Category:** Utility  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Captures raw network traffic and pipes each chunk through SHA-256, appending the hashes to a file on the USB drive. The result is high-quality randomness derived from real-world network entropy — packet timing, payload content, source addresses, and protocol variations.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Red | Harvesting entropy |
| Solid Green | Stopped |

## Loot Location

```
/usb/loot/entropy/true_random.txt
```
