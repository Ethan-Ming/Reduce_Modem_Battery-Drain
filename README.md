#  RMBD (Magisk Modules)

[![中文](https://img.shields.io/badge/ZH-中文說明-red.svg)](https://github.com/Ethan-Ming/Reduce_Modem_Battery-Drain/blob/main/%E8%AE%80%E6%88%91.md)
      
    
    
      
    
      
This repository contains **two Magisk modules** designed to reduce **idle battery drain caused by Wi-Fi multicast traffic** on Android devices (especially Pixels), while preserving usability for discovery-based features like **Chromecast** and **smart-home setup**.
      
    
    
      
    
      
    
    
      
    

Both modules work by controlling the **Wi-Fi interface multicast flag**, which directly affects:
- `WifiMulticastOn`
- Radio wakeups (e.g. `dhdpcie_host_wake`)
- Screen-off idle drain

Root (Magisk) is required.

---

## Background (Why this exists)

Many apps (Google Play services, Instagram, WeChat, media apps, etc.) hold multicast locks unnecessarily.  
This causes:
- High screen-off battery drain
- CPU + Wi-Fi radio being pulled out of suspend
- `WifiMulticastOn` staying active for hours
- Frequent Wi-Fi driver interrupts



Android does **not** aggressively police multicast usage by default.

These modules fix that.

---

## Modules Overview

### 1️⃣ RMBD (Hard OFF)

**Best for:** Maximum battery life, minimal discovery usage

#### What it does
- Disables Wi-Fi multicast **globally**
- Multicast stays OFF as long as the module is enabled
- Requires reboot to apply
- Discovery features (Chromecast, smart-home pairing) will **not work** while enabled

#### Behavior
| State | Multicast |
|----|----|
| Boot | OFF |
| Screen ON | OFF |
| Screen OFF | OFF |

#### Pros
- Maximum reduction of idle drain
- Simple, stable, zero background logic

#### Cons
- No Chromecast / mDNS / UPnP discovery while enabled

---

### 2️⃣ RMBD_screen_aware (Recommended for most users)

**Best for:** Users who frequently use Chromecast or smart-home discovery

#### What it does
- **Automatically disables multicast when the screen is OFF**
- **Automatically re-enables multicast when the screen is ON**
- No manual toggling
- Discovery works normally while you are actively using the phone

#### Behavior
| Screen state | Multicast | Discovery |
|-----------|----------|----------|
| ON | ON | Works |
| OFF | OFF | Disabled |

#### Pros
- Large reduction in idle battery drain
- Chromecast / smart-home still works
- Fully automatic

#### Cons
- Small background loop (5s polling, negligible power cost)

---

## Which module should I use?

| Use case | Recommended module |
|------|------------------|
| Maximum battery life | **RMBD** |
| Chromecast / smart-home user | **RMBD_screen_aware** |
| Mostly idle phone | **Either** |
| Forgetful about toggles | **RMBD_screen_aware** |

---

## Installation

### Requirements
- Rooted Android device
- Magisk installed
- Reboot capability

### Steps
1. Download the desired ZIP:
   - `RMBD.zip` for max battery saving
  
     
      **or**
   - `RMBD_screen_aware.zip` take slight hit in battery but keep smarthome discovery and chromecast working
2. Open **Magisk**
3. Go to **Modules → Install from storage**
4. Select the ZIP
5. Reboot

---

## Verification (optional)

After reboot:

### Screen ON
```bash
adb shell su -c "ip link show wlan1 | grep MULTICAST"
