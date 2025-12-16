#!/system/bin/sh

# wait for full boot
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 2
done
sleep 10

# disable Wi-Fi multicast
dumpsys wifi disable-multicast

# disable Nearby Share
settings put global nearby_sharing_enabled 0
settings put secure nearby_sharing_slice_enabled 0

# force LTE only (SIM 1 & SIM 2)
settings put global preferred_network_mode 11
settings put global preferred_network_mode1 11
