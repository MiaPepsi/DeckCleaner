#! /bin/bash

# this script will clear the shadercache folder from your steamdeck

shadersize=$(du -sh /home/deck/.steam/steam/steamapps/shadercache)


SD=1 # OK button return code =0 , all others =1
mover=0
while [ $SD -eq 1 ]; do
  ans=$(zenity --info --title 'Confirm deletion' \
      --text="shadercache size: $shadersize \n\n do you wish to clear this data?" --no-wrap \
      --ok-label Quit \
      --extra-button yes \
      --extra-button no \
      --extra-button "move shaderache to SD card" \
       )
  
  
  SD=$?
  echo "${SD}-${ans}"
  echo $ans
  if [[ $ans = "yes" ]]
  then
  rm -r /home/deck/.steam/steam/steamapps/shadercache
       zenity --info --title="Success" --text="shadercache folder was sucessfully deleted" --no-wrap
  	SD=0
  
  
  
  elif [[ $ans = "no" ]]
  then
        zenity --info --title="no content deleted" --text="The shadercache folder was not deleted" --no-wrap
      	SD=0
  
  
  
  elif [[ $ans = "move shaderache to SD card" ]]
  then
  	if zenity --question --title="Confirm move" --text="move shadercache to SDcard?" --no-wrap 
    then
    mv /home/deck/.steam/steam/steamapps/shadercache /run/media/mmcblk0p1/steamapps/
    ln -s /run/media/mmcblk0p1/steamapps/ /home/deck/.steam/steam/steamapps/shadercache
    SD=0
        zenity --info --title="Success" --text="shadercache folder was sucessfully moved to the SD card" --no-wrap
    else
    	zenity --info --title="no content moved" --text="The shadercache folder was not moved" --no-wrap
fi
    fi
done
