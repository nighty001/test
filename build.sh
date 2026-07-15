#!/bin/sh
set -eu
cd "$(dirname "$0")"
rm -rf .build output
mkdir -p .build output
cp -a config .build/
cd .build
lb clean --purge || true
lb config \
  --mode debian \
  --architectures amd64 \
  --distribution bookworm \
  --mirror-bootstrap http://deb.debian.org/debian \
  --mirror-chroot http://deb.debian.org/debian \
  --mirror-binary http://deb.debian.org/debian \
  --archive-areas "main contrib non-free-firmware" \
  --binary-image iso-hybrid \
  --debian-installer live \
  --debian-installer-gui false \
  --bootappend-live "boot=live components quiet splash loglevel=3 systemd.show_status=false" \
  --iso-application "N36 ESP32 Kiosk" \
  --iso-publisher "Local kiosk image"
lb build
cp live-image-amd64.hybrid.iso ../output/n36-kiosk-amd64.iso
sha256sum ../output/n36-kiosk-amd64.iso > ../output/n36-kiosk-amd64.iso.sha256
