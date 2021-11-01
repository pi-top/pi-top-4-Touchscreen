# pi-top [4] Touchscreen

This package manages a udev rule and a systemd service to allow plug-and-play network connection with a pi-top [4] Touchscreen via its Display Port.

The udev rule identifies when the Touchscreen's USB touch panel is connected, and leaves a breadcrumb that is used by the systemd service to then update the resolution and unblank the display.
