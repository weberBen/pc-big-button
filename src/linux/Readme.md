# Installation

`chmod +x install.sh` and start the script

If you want to run the script one use the command `bigbutton start` (note that only one instance of the script can be running at the same time).

If you want to run the script at each startup you have to use the file `<installation_dir>/bigButton/bigButton_launcher>` and link it to 
the correct location for your OS (for example, with ubuntu and gnome you just have to add a new entry in the *Startup* script window)


# About

## Device identification

The device is identified by the vendor id, the product id and if it has a serial number (which is not the case for all arduino clones) the serial number.

Thus, if you have two same arduino (same manufacturer and model) connected to your computer that do not have a distinct serial number, you will have a problem/a mismatch

## Serial com
The installation creates a new group *arduino-serial* for a normal user to read and write to the serial port on which the arduino is connected to.
And a udev rule is created to add that group to the owners of the device.

An alternative would have been to add the current user to the *dialout* group, but it will affect all the serial port (and not only the desired
arduino device)

## Notification

The demo event scripts use `notify-send` which will show notifications one by one (when the previous has disappeared) if started by the current user.

To have multiple notifications displayed at the same time (as in the demo) run the script with `sudo`


# Event script

The supported events are :

- device added (plugged): *event-scripts/device/added*
- device removed (unplugged): *event-scripts/device/removed*
- device ready (the serial communication has been established with the arduino): *event-scripts/device/ready*
- button down: *event-scripts/button/down*
- button up: *event-scripts/button/up*

To create a custom script add a new file in the desired event directory and make it executable (you can remove the demo scripts)


# Uninstallation

In a terminal run :

`bigbutton uninstall`
