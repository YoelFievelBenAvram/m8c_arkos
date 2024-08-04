#!/bin/bash


sed -i "/^idle_ms=/s/=.*/=25/" ~/.local/share/m8c/config.ini

m8c_path=ports
roms2_path=/roms2/$m8c_path
roms_path=/roms/$m8c_path

if [ -e "$roms2_path" ]; then
  cd $roms2_path
else
  cd $roms_path
fi

sudo apt update --assume-yes && sudo apt install -y git gcc pkg-config make libsdl2-dev libserialport-dev libserialport0 pulseaudio
sudo adduser $USER dialout
