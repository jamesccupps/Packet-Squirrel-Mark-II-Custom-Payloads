# API Panic Button

**Category:** Home Automation  
**Net Mode:** BRIDGE

## Description

Turns the Packet Squirrel into a physical IoT button. Each button press fires a Home Assistant webhook with a JSON payload. Loops indefinitely — press as many times as you want.

## Setup

Edit `HA_WEBHOOK` at the top of the script:
```bash
HA_WEBHOOK="http://192.168.1.XXX:8123/api/webhook/your_secret_webhook_id"
```

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Ready — waiting for press |
| Blinking Red | Firing webhook |
| Solid Green | Webhook sent — resetting |

## Webhook Payload

```json
{"source": "packet_squirrel", "action": "panic_button_pressed"}
```
