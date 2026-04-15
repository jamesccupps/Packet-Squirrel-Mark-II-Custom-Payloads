# Physical Pomodoro

**Category:** Utility  
**Net Mode:** BRIDGE

## Description

Hardware-level distraction blocker using the Pomodoro Technique. Press the button to start a 25-minute focus sprint — Reddit, YouTube, Twitter, and Facebook are blocked at the network level via `iptables` string matching. After 25 minutes, the blocks lift for a 5-minute break, then the cycle resets.

## LED States

| LED | Meaning |
|-----|---------|
| Blinking Yellow | Ready — press button to start |
| Solid Red | Focus mode (25 min) — sites blocked |
| Solid Green | Break time (5 min) — sites unblocked |

## Blocked Sites

- reddit.com
- youtube.com
- twitter.com
- facebook.com

Edit the `iptables` rules in the script to customize the block list.
