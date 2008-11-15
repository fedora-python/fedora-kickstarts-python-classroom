###### Eee PC 900 stuff ####################################################
#
###### Hotkeys #############################################################
cat > /etc/acpi/actions/hotkeys.sh << EOHOTKEY
#!/bin/bash

export DISPLAY=:0

case "$3" in

    #Fn+F2
    00000010)
        # Wlan On
        /etc/acpi/actions/wlan.sh poweron
        ;;
    00000011)
        # Wlan Off
        /etc/acpi/actions/wlan.sh poweroff
        ;;

    #Fn+F6
    00000012)
        # Webcam switch
        /etc/acpi/actions/camera.sh
        # TaskManager
	# /usr/bin/gnome-system-monitor
	;;

    #Fn+F7
    00000013)
        # Volume mute
	/usr/bin/amixer set -D hw:0 Master toggle
	;;

    #Fn+F8
    00000014)
        # Volume down
        /usr/bin/amixer set -D hw:0 Master 10%- unmute
        ;;

    #Fn+F9
    00000015)
        # Volume up
        /usr/bin/amixer set -D hw:0 Master 10%+ unmute
        ;;

    #Fn+F5
    00000030)

	/usr/bin/xrandr --output VGA  --mode 1024x768 \
			--output LVDS --off

	if [[ "$?" != "0" ]]; then

	/usr/bin/xrandr --output VGA  --preferred \
			--output LVDS --off

	fi
	;;

    00000031)

	/usr/bin/xrandr --output LVDS --mode 800x480 \
		        --output VGA  --mode 800x600

        ;;
    
    00000032)

	/usr/bin/xrandr --output VGA  --off       \
           		--output LVDS --preferred

        ;;
    *)
        logger "ACPI hotkey $3 action is not defined"
        ;;
esac
EOHOTKEY

###### WLAN #############################################################
cat > /etc/acpi/actions/wlan.sh << EOF
#!/bin/bash

PWR=$(cat /sys/devices/platform/eeepc/wlan)

UnloadModules() {
    rmmod ath_pci
    rmmod ath_rate_sample
    rmmod wlan_scan_sta
    rmmod wlan_tkip
    rmmod wlan_wep
    rmmod wlan
}

LoadModules() {
    modprobe ath_pci
}

case $1 in
    poweron)
        if [[ "$PWR" = "0" ]]; then
            modprobe pciehp pciehp_force=1

	    echo 1 > /sys/devices/platform/eeepc/wlan

	    rmmod pciehp

        fi
        ;;
           
    poweroff)
        if [[ "$PWR" = "1" ]]; then

            modprobe pciehp pciehp_force=1

            ifconfig ath0 down

            wlanconfig ath0 destroy

            UnloadModules

            echo 0 > /sys/devices/platform/eeepc/wlan

            rmmod pciehp

        fi
        ;;
esac
EOF

###### Webcam #############################################################
cat > /etc/acpi/actions/camera.sh << EOF

#!/bin/bash

CAMERA=$(cat /sys/devices/platform/eeepc/camera)

        if [[ "$CAMERA" = "0" ]]; then
   	    echo 1 > /sys/devices/platform/eeepc/camera
         else
            echo 0 > /sys/devices/platform/eeepc/camera
        fi
EOF

chmod +x "/etc/acpi/actions/*"

###### Shutdown fix #########################################################
echo "modprobe -r snd-hda-intel" >> /sbin/halt.local
chmod 755 /sbin/halt.local

###### Gnome display stuff ##################################################

gconftool-2 --type boolean --set /apps/nautilus/preferences/always_use_browser true