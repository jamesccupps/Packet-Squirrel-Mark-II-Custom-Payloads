# Camera Shadow Recorder

**Category:** Sniffing  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Passively captures RTSP video streams (port 554) from an inline IP camera. The camera continues streaming to the NVR normally, but the Squirrel silently saves a copy of the raw stream to USB. Rotates capture files every hour to prevent corruption.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Red | Recording |
| Solid Green | Stopped |

## Loot Location

```
/usb/loot/video_backup/camera_YYYY-MM-DD_HHMM.pcap
```

## Notes

- File rotation every 3600 seconds (1 hour)
- USB storage fills quickly with raw video — use a large drive
