# Packet Capture — Manual (Interactive & Looping)

**Category:** Sniffing  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Interactive packet capture with full looping support. Press the button to start capturing, press again to stop. The payload saves each capture as a separate timestamped file and immediately returns to the ready state — no reboot required between runs.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Ready — waiting for button press to start |
| Blinking Red | Capturing packets |
| Solid Green | Capture stopped successfully |

## Features

- Web UI enabled for remote access
- Auto-creates `/usb/loot/tcpdump/` directory
- Timestamped filenames prevent overwrites
- USB space monitor kills tcpdump if drive drops below 10MB
- Loops indefinitely — start/stop as many captures as needed

## Loot Location

```
/usb/loot/tcpdump/dump_YYYY-MM-DD-HHMMSS.pcap
```

## Exfiltration

**Option 1 — Browser:** SSH in, run `python3 -m http.server 8080` from the loot directory, then browse to `http://<SQUIRREL_IP>:8080`

**Option 2 — SCP:** `scp -r root@<SQUIRREL_IP>:/usb/loot/tcpdump/ .`
