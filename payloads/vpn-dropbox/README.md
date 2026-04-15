# VPN Drop Box

**Category:** Remote Access  
**Net Mode:** BRIDGE  
**Requires:** OpenVPN config file on USB

## Description

Bridges the local connection and automatically establishes an OpenVPN tunnel back to your server. Once connected, you can SSH into the Squirrel from anywhere in the world through the VPN.

## Setup

Place your OpenVPN configuration file on the USB drive as:
```
/usb/dropbox.ovpn
```

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Cyan | Waiting for internet connectivity |
| Blinking Yellow | Attempting VPN connection |
| Solid Cyan | VPN tunnel established |
| Solid Red | VPN connection failed |
| Blinking Red (FAIL) | Config file not found on USB |
