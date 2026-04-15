# Hotel Stealth NAT

**Category:** Utility  
**Net Mode:** NAT

## Description

Clones your authenticated device's MAC address and turns the Squirrel into a NAT router. Designed for hotel/resort networks that limit connections to one device. Authenticate once with your laptop, press the button, and plug a travel switch or AP into the Squirrel to share the connection across all your devices.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Ready — waiting for button press |
| Blinking Purple | Cloning MAC address |
| Solid Green | NAT active — plug in your switch/AP |
| Blinking Red (FAIL) | Failed to detect client MAC |

## Requirements

- `macchanger` (auto-installed via opkg if missing)
- First boot requires internet access for opkg install
