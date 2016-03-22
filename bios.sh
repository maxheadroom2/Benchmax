#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0



echo martha456 | sudo -S ls /root && sudo hwclock --hctosys
sleep 2s;
gnome-terminal -x sh /home/ghiatest/rutinas/control_de_ventanas.sh
amixer sset Master  100% unmute & amixer sset Speaker  100% unmute & amixer sset PCM  100% unmute & amixer sset Headphone  100% unmute
nohup gnome-terminal -x mplayer -shuffle /home/ghiatest/Música/*.mp3
notify-send "Inicia el Audio"
