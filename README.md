# Packet Squirrel Mark II — Custom Payloads

A collection of 23 custom payloads for the [Hak5 Packet Squirrel Mark II](https://shop.hak5.org/products/packet-squirrel-mark-ii), ranging from packet capture and network recon to OT security tools, home automation triggers, and chaos generators.

Each payload is fully standalone — just copy the `payload.sh` file to your Packet Squirrel's USB drive and go.

## Payloads

### Packet Capture

| Payload | Description |
|---------|-------------|
| [packet-capture-manual](payloads/packet-capture-manual/) | Interactive capture with button start/stop and looping |
| [packet-capture-auto](payloads/packet-capture-auto/) | Auto-start capture with BPF noise filters |
| [camera-shadow-recorder](payloads/camera-shadow-recorder/) | Silently captures RTSP video streams as a backup |

### Network Recon

| Payload | Description |
|---------|-------------|
| [stealth-subnet-mapper](payloads/stealth-subnet-mapper/) | Fast Nmap sweep with MAC spoofing and decoys |
| [sdn-interceptor](payloads/sdn-interceptor/) | Captures UniFi STUN/Inform traffic to map SDN infrastructure |
| [rogue-device-hunter](payloads/rogue-device-hunter/) | Learns MAC baseline, alerts on new devices |

### OT / Building Automation

| Payload | Description |
|---------|-------------|
| [bms-watchdog](payloads/bms-watchdog/) | Captures BACnet (47808) and Modbus (502) traffic |
| [ot-traffic-visualizer](payloads/ot-traffic-visualizer/) | LED-based real-time OT protocol monitor |
| [broadcast-suppressor](payloads/broadcast-suppressor/) | Rate-limits BACnet broadcasts to protect legacy controllers |
| [vendor-honeypot](payloads/vendor-honeypot/) | Fake BMS login page that logs connection attempts |

### Network Defense

| Payload | Description |
|---------|-------------|
| [iot-quarantine](payloads/iot-quarantine/) | Physical firewall — allows LAN, blocks all internet |
| [ha-tripwire](payloads/ha-tripwire/) | Fires a Home Assistant webhook on traffic anomalies |
| [printer-auditor](payloads/printer-auditor/) | Monitors printer protocols and flags cloud phone-home attempts |

### Pentest

| Payload | Description |
|---------|-------------|
| [serial-credential-sieve](payloads/serial-credential-sieve/) | Streams plaintext HTTP credentials to UART serial |
| [print-spool-sniffer](payloads/print-spool-sniffer/) | Captures unencrypted print job traffic |

### Remote Access & Utility

| Payload | Description |
|---------|-------------|
| [vpn-dropbox](payloads/vpn-dropbox/) | Auto-establishes an OpenVPN tunnel for remote access |
| [hotel-stealth-nat](payloads/hotel-stealth-nat/) | MAC cloning NAT router for hotel networks |
| [sneakernet-micro-nas](payloads/sneakernet-micro-nas/) | HTTP file server from the USB drive |
| [entropy-harvester](payloads/entropy-harvester/) | Converts network noise into cryptographic randomness |

### Home Automation

| Payload | Description |
|---------|-------------|
| [api-panic-button](payloads/api-panic-button/) | Physical button that fires a Home Assistant webhook |

### Chaos

| Payload | Description |
|---------|-------------|
| [network-glitch-art](payloads/network-glitch-art/) | 1% packet corruption for glitch art generation |
| [chaos-engine](payloads/chaos-engine/) | Injects 250ms delay + jitter (the lag switch) |
| [physical-pomodoro](payloads/physical-pomodoro/) | Hardware Pomodoro timer that blocks distracting sites |

## Installation

1. Format a USB drive as ext4 or NTFS
2. Create a `/payloads/` directory on the drive (or use the switch-based folder structure — see [Hak5 docs](https://docs.hak5.org/packet-squirrel-mark-ii/))
3. Copy the desired `payload.sh` into the appropriate payload folder
4. Insert the USB drive into the Packet Squirrel and power on

## LED Reference

Most payloads follow a consistent LED convention:

| LED Pattern | Typical Meaning |
|-------------|-----------------|
| Blinking Yellow | Setup / Waiting |
| Blinking Red | Active operation (capture, scan, attack) |
| Solid Green | Success / Complete |
| Blinking Red (FAIL) | Error |
| Solid Cyan | Firewall or server active |
| Blinking Purple | Special mode |

Check each payload's README for its specific LED states.

## Exfiltrating Loot

Most capture payloads save files to `/usb/loot/`. To retrieve them:

**Browser download:** SSH into the Squirrel, navigate to the loot directory, and run `python3 -m http.server 8080`. Then browse to `http://<SQUIRREL_IP>:8080`.

**SCP:** From your local machine, run `scp -r root@<SQUIRREL_IP>:/usb/loot/ .`

**Sneakernet:** Several payloads save the Squirrel's IP to `/usb/squirrel_ip.txt`. Pull the USB drive, read the IP, re-insert the drive, and connect directly.

## License

MIT — see [LICENSE](LICENSE).
