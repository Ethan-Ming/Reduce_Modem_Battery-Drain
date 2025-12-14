#!/system/bin/sh
# Disable Wi-Fi multicast to reduce battery drain

# wait until wifi interface exists
until ip link show wlan0 >/dev/null 2>&1; do
    sleep 2
done

ip link set wlan0 multicast off
