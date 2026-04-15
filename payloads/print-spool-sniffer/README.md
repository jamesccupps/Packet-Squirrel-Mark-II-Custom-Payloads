# Print Spool Sniffer

**Category:** Pentest  
**Net Mode:** BRIDGE  
**Requires:** USB storage

## Description

Captures unencrypted print traffic from Raw Print / JetDirect (port 9100) and IPP (port 631). Most workstations send documents to network printers completely unencrypted — this payload captures the spool files which can be reconstructed into the original printed documents.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Purple | Sniffing print traffic |
| Solid Green | Stopped |

## Loot Location

```
/usb/loot/print_jobs/spool_YYYYMMDD_HHMM.pcap
```
