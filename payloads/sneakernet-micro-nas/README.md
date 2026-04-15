# Sneakernet Micro-NAS

**Category:** Utility  
**Net Mode:** BRIDGE  
**Requires:** python3

## Description

Turns the Squirrel into an instant HTTP file server. Load files onto the USB drive, plug the Squirrel inline, and anyone on the network can browse and download files at `http://<SQUIRREL_IP>:8000`. Saves the access URL to the USB drive for Sneakernet retrieval.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Cyan | Starting up |
| Solid Cyan | Server running |
| Solid Green | Server stopped |

## Access

```
/usb/nas_ip.txt    # Contains the access URL
```
