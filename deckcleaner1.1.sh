#! /bin/bash

# this script will clear the shadercash folder from your steamdeck

shadersize=$(du -sh /home/deck/.steam/steam/steamapps/shadercache)

if zenity --question --title="Confirm deletion" --text="shadercache size: $shadersize \n\n do you wish to clear this data?" --no-wrap 
    then
    rm -r /home/deck/.steam/steam/steamapps/shadercache
        zenity --info --title="Success" --text="shadercache folder was sucessfully deleted" --no-wrap
    else
    	zenity --info --title="no content deleted" --text="The shadercache folder was not deleted" --no-wrap
fi
