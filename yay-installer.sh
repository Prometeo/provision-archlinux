#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"


### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
echo -e "$CNT - The following file has been created $LOC."
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC &>> $INSTLOG
echo -e "\n"
echo -e "$CNT - Restarting NetworkManager service..."
# sleep 1
# sudo systemctl restart NetworkManager
# sleep 3


### Install needed pacakges with yay ####
echo -e "$COK - Updating yay database..."
yay -Suy --noconfirm

echo -e "\n$CNT - Stage 1 - Installing main components, this may take a while..."
for SOFTWR in swww swaylock-effects wofi wlogout
do
    #First lets see if the package is there
    if yay -Qs $SOFTWR > /dev/null ; then
        echo -e "$COK - $SOFTWR is already installed."
    else
        echo -e "$CNT - Now installing $SOFTWR ..."
        yay -S --noconfirm $SOFTWR
        if yay -Qs $SOFTWR > /dev/null ; then
            echo -e "$COK - $SOFTWR was installed."
        else
            echo -e "$CER - $SOFTWR install had failed"
            exit
        fi
    fi
done

# Start the bluetooth service
echo -e "$CNT - Starting the Bluetooth Service..."
sudo systemctl enable --now bluetooth.service

# Enable the sddm login manager service
echo -e "$CNT - Enabling the SDDM Service..."
sudo systemctl enable sddm
sleep 2
