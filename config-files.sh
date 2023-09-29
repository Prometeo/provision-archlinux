#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

# path of sdt directory
$1

# Copy the SDDM theme
echo -e "$CNT - Setting up the login screen."
sudo cp -R $1/sdt /usr/share/sddm/themes/
sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
sudo mkdir /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=sdt" | sudo tee -a
/etc/sddm.conf.d/10-theme.conf
WLDIR=/usr/share/wayland-sessions
if [ -d "$WLDIR" ]; then
    echo -e "$COK - $WLDIR found"
else
    echo -e "$CWR - $WLDIR NOT found, creating..."
    sudo mkdir $WLDIR
fi
sudo cp hyprland.desktop /usr/share/wayland-sessions/
sudo sudo sed -i 's/Exec=Hyprland/Exec=\/home\/'$USER'\/start-hypr/' /usr/share/wayland-sessions/hyprland.desktop
cp start-hypr ~/
chmod +x ~/start-hypr

#setup the first look and feel as dark
ln -sf ~/.config/waybar/style/style-dark.css ~/.config/waybar/style.css
ln -sf ~/.config/wofi/style/style-dark.css ~/.config/wofi/style.css
xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita-dark"
ln -sf /usr/share/sddm/themes/sdt/Backgrounds/wallpaper-dark.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
