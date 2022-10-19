#!/bin/bash

# this script will clear the shadercache folder from your steamdeck

# get SD Card name (Thank you EmuDeck for this)
if [ -b "/dev/mmcblk0p1" ]; then
  sdCard=$(findmnt -n --raw --evaluate --output=target -S /dev/mmcblk0p1)
  sdshadersize=$(shopt -s lastpipe; du -sh ${sdCard}/steamapps/shadercache | grep -E -o "(.*[GMK])")
fi
# sdCard=$(ls /run/media | grep -ve '^deck$' | head -n1)
internalshadersize=$(shopt -s lastpipe; du -sh $HOME/.steam/steam/steamapps/shadercache | grep -E -o "(.*[GMK])")


PS3='Please enter your choice: '
if [ -b "/dev/mmcblk0p1" ]; then
  options=(
      "Remove ${internalshadersize:=0B} of shadercache from internal storage."
      "Remove ${sdshadersize:=0B} of shadercache from SD card."
      "Move ${internalshadersize} of shadercache from internal storage to SD card."
      "Quit"
  )
else options=(
     "Remove ${internalshadersize:=0B} of shadercache from internal storage."
        "SD Card Not Found"
        "Quit"
)
fi

while opt=$(zenity --width=500 --height=250 --title="$title" --text="$prompt" --list --column="Options" "${options[@]}");
    do
        case "$opt" in
            "${options[0]}" ) 
                rm -r /home/deck/.steam/steam/steamapps/shadercache
                zenity --info --title="Success" --text="The shadercache folder was sucessfully deleted from internal storage." --no-wrap
                options[0]="The shadercache folder was sucessfully deleted from internal storage."
                options[2]="Shader folder cannot be moved. Does not exist."
                ;;
              "${options[1]}" )
                if [ -b "/dev/mmcblk0p1" ]; then
                  rm -r ${sdCard}/steamapps/shadercache
                  zenity --info --title="Success" --text="The shadercache folder was sucessfully deleted from SD card." --no-wrap
                  options[1]="The shadercache folder was sucessfully deleted from SD card."
                else break
                fi
                  ;;
              "${options[2]}" )
                if [ -b "/dev/mmcblk0p1" ]; then
                  mv /home/deck/.steam/steam/steamapps/shadercache ${sdCard}/steamapps/
                  ln -s ${sdCard}/steamapps/ /home/deck/.steam/steam/steamapps/shadercache
                  zenity --info --title="Success" --text="The shadercache folder was sucessfully moved to the SD card." --no-wrap
                  options[2]="The shadercache folder was sucessfully moved to the SD card."
                else break
                fi
                  ;;
            "${options[3]}" ) break;;
            *) zenity --error --text="Invalid option. Try another one.";;
        esac
done