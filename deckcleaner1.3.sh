#!/bin/bash

# this script will clear the shadercache folder from your steamdeck

internalshadersize=$(shopt -s lastpipe; du -sh /home/deck/.steam/steam/steamapps/shadercache | grep -E -o "(.*[GMK])")
sdshadersize=$(shopt -s lastpipe; du -sh /run/media/mmcblk0p1/steamapps/shadercache | grep -E -o "(.*[GMK])")

PS3='Please enter your choice: '
options=(
    "Remove ${internalshadersize:=0B} of shadercache from internal storage."
    "Remove ${sdshadersize:=0B} of shadercache from SD card."
    "Move ${internalshadersize:=0B} of shadercache from internal storage to SD card."
    "Quit"
)

while opt=$(zenity --width=450 --height=250 --title="$title" --text="$prompt" --list --column="Options" "${options[@]}");
    do
        case "$opt" in
            "${options[0]}" ) 
                rm -r /home/deck/.steam/steam/steamapps/shadercache
                zenity --info --title="Success" --text="The shadercache folder was sucessfully deleted from internal storage." --no-wrap
                ;;
            "${options[1]}" )
                rm -r /run/media/mmcblk0p1/steamapps/shadercache
                zenity --info --title="Success" --text="The shadercache folder was sucessfully deleted from SD card." --no-wrap
                ;;
            "${options[2]}" )
                mv /home/deck/.steam/steam/steamapps/shadercache /run/media/mmcblk0p1/steamapps/
                ln -s /run/media/mmcblk0p1/steamapps/ /home/deck/.steam/steam/steamapps/shadercache
                zenity --info --title="Success" --text="The shadercache folder was sucessfully moved to the SD card" --no-wrap
                ;;
            "${options[3]}" ) break;;
            *) zenity --error --text="Invalid option. Try another one.";;
        esac
done