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

# set cpu governor to powersave to minimize audio "crackles"
echo "ondemand" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

sudo pulseaudio --start --system
pacmd load-module module-loopback latency_msec=1 set-source-port alsa_input.usb-DirtyWave_M8_15867250-02.analog-stereo set-sink-port alsa_output.platform-rk817-sound.stereo-fallback
sleep 2
./m8c/m8c
sudo pkill pulseaudio
