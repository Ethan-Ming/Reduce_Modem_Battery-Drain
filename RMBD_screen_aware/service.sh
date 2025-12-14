#!/system/bin/sh

get_wifi_iface() {
    ip link | awk -F': ' '/wlan|wifi/{print $2; exit}'
}

IFACE="$(get_wifi_iface)"
[ -z "$IFACE" ] && IFACE="wlan0"

log_msg() {
    log -t MulticastSA "$1"
}

while true; do
    if dumpsys power | grep -q "Display Power: state=OFF"; then
        ip link set "$IFACE" multicast off 2>/dev/null
        log_msg "Screen OFF → multicast OFF"
    else
        ip link set "$IFACE" multicast on 2>/dev/null
        log_msg "Screen ON → multicast ON"
    fi
    sleep 5
done
