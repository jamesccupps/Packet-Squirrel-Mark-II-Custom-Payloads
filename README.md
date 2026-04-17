# Packet Squirrel Mark II — Custom Payloads

A collection of 23 custom payloads for the [Hak5 Packet Squirrel Mark II](https://shop.hak5.org/products/packet-squirrel-mark-ii) — a pocket-sized Linux device that sits inline on an Ethernet connection. These payloads cover packet capture, network recon, OT security tooling, home-automation triggers, and a few chaos generators.

Each payload is fully standalone — drop the `payload.sh` file onto your Packet Squirrel's USB drive and go.

> ⚠️ **Authorized use only.** These payloads perform packet capture, network scanning, credential interception, and traffic manipulation. Deploy them only on networks you own or have explicit written permission to test. See the [Disclaimer](#disclaimer) at the bottom of this document.

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

The Packet Squirrel Mark II has a four-position physical switch on the side. Each switch position runs a separate payload, so you can stage up to four tools on a single USB drive and pick which one fires by moving the switch before power-on.

1. **Format a USB drive as ext4.** FAT32 also works but limits filenames and max file size; ext4 is what the Hak5 docs recommend.
2. **Create the payload folders on the drive:**
   ```
   /payloads/switch1/
   /payloads/switch2/
   /payloads/switch3/
   /payloads/switch4/
   ```
3. **Copy a `payload.sh` into the folder that matches the switch position you want to assign it to.** You can put a different payload in each folder and swap between them with the switch.
4. Insert the USB drive, set the physical switch to the position you want, and power on.

Full device docs: [Hak5 Packet Squirrel Mark II documentation](https://docs.hak5.org/packet-squirrel-mark-ii/).

## LED Reference

The Mark II's onboard LED is used for payload status. Most payloads follow a rough convention, but each payload's own README is the authoritative source for its specific LED states — some reuse the same color for different phases.

| LED Pattern | Common Meaning |
|-------------|----------------|
| Blinking Yellow | Setup, waiting for IP or user input |
| Slow Blinking Red | Active operation — capture, scan, or attack running |
| Fast Blinking Red | Error or failure state |
| Solid Green | Done, capture stopped, or success |
| Solid Cyan | Firewall, HTTP server, or listener active |
| Blinking Purple | Special mode (varies by payload) |

Check each payload's README for its exact LED behavior.

## Exfiltrating Loot

Most capture payloads save files to `/usb/loot/`. Three ways to retrieve them:

**Browser download.** SSH into the Squirrel, navigate to the loot directory, and run `python3 -m http.server 8080`. Then browse to `http://<SQUIRREL_IP>:8080`.

**SCP.** From your local machine: `scp -r root@<SQUIRREL_IP>:/usb/loot/ .`

**Sneakernet.** Several payloads write the Squirrel's IP to `/usb/squirrel_ip.txt`. Pull the USB drive, read the IP on another machine, re-insert the drive, and connect directly.

## Contributing

New payloads are welcome. The existing ones follow a consistent structure:

```
payloads/<payload-name>/
├── README.md       # Category, Net Mode, LED states, use cases
└── payload.sh      # The actual executable
```

Keep payloads self-contained — no external dependencies beyond what's already on the Packet Squirrel (`tcpdump`, `tc`, `nmap`, `opkg`, etc.), or auto-install them at the top of `payload.sh` with `opkg` if they're missing.

## License

MIT — see [LICENSE](LICENSE).

## Disclaimer

These payloads are intended for authorized security testing, network research, and defensive monitoring on networks you own or have explicit written permission to test. Many of these tools — including credential sieves, honeypots, packet capture, traffic manipulation, and protocol fuzzing — perform actions that may be illegal when used without authorization. Unauthorized interception of network communications may violate federal and state wiretap laws (including 18 U.S.C. § 2511 in the United States) as well as computer fraud and abuse statutes. The OT/building-automation payloads can interact with live industrial control systems; do not deploy them on production BAS/ICS networks without coordination with the system owner and operator. You are solely responsible for how you use this software. The author assumes no liability for misuse or damages.
