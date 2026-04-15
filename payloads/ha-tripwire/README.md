# Home Assistant Tripwire

**Category:** Defense  
**Net Mode:** BRIDGE

## Description

Continuously monitors network packet rate and fires a Home Assistant webhook when an anomaly is detected (e.g., broadcast storm, Nmap scan). Includes a 60-second cooldown between alerts to avoid notification spam.

## Setup

Edit `HA_URL` at the top of the script with your Home Assistant IP and webhook ID:
```bash
HA_URL="http://192.168.1.XX:8123/api/webhook/your_custom_webhook_id"
```

Create a webhook automation in HA to trigger notifications, alarms, lights, or any other action.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Monitoring |
| Blinking Red (fast) | Anomaly detected — webhook fired |

## Detection Threshold

Triggers when more than 400 packets are seen in a 5-second window.
