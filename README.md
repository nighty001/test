# N36 ESP32 kiosk image

This project builds a Debian 12 (Bookworm) amd64 live installer image for the
MINISFORUM N36. The installed system starts Chromium in kiosk mode at
`http://192.168.4.1/view` and toggles to/from `/roundview` when the ACPI power
button is pressed.

The browser profile lives in `/run`, so every boot starts with exactly one
fresh tab. systemd-logind shutdown/suspend handling for the power key is
disabled; a long hardware press can still force power-off.

Build on Debian 12/Ubuntu as root:

    apt-get update
    apt-get install -y live-build
    ./build.sh

The resulting hybrid ISO is written to `output/n36-kiosk-amd64.iso` and can be
flashed with Rufus in DD mode or balenaEtcher.

Installation deliberately erases the first internal non-USB SATA/NVMe disk.
USB drives and removable card-reader media are excluded. Keep only the intended
internal SSD and the installer USB connected.
