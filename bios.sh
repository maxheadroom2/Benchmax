#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0

###############################################################################
# descripcion:
# 1 -Te pide tu contraseña de SUDO para evitar tener que teclear en consola
# 2 -Sincroniza la Hora del sistema con la del BIOS
# 3 -Sube volumen y quita el mute si lo tiene
# 4 -Inicia el reproducto de musica para la salida de audio
# 5 -Inicia el siguiente script que controla las ventanas
###############################################################################

# LISTADO DE PROCESOS ----------------------------------------------------------
# gnome-terminal  < Terminal de gnome
# amixer          < Gestor del Audio
# mplayer         < Reproductor
# LISTADO DE SCRIPTS HIJOS -----------------------------------------------------
# /home/$ruta0/control_de_ventanas.sh        < ejecuta pruebas de Hardware y HD
#
################################################################################
# variables del sistema



# inicio de las rutinas

ruta0=maxheadroom
ruta1=Rutinas
usb=series

wmctrl  -r "./bios.sh" -b toggle,maximized_vert,maximized_horz

pass="/tmp/pass.txt"
dialog --title "" --backtitle "BENCHMAX" \
--inputbox "Ingresa tu clave SUDO ya que se verificara si tienes algunos Demonios Instalados para el Benchmark del Sistema: " 8 60 2>"${pass}"
sel=$?
pass=`cat /tmp/pass.txt`
case $sel in
  0) dialog --backtitle "BENCHMAX" --title "esta es tu Password ingresado" --msgbox "Ingresaste el siguiente Password $pass "  7 70;;
  1) clear; exit 0;;
esac

clear
#rm -f /tmp/pass.txt #para borrar el temporal

# inicia la revision de los programas Instalados

programas="/tmp/listaprogra.txt"
dpkg --get-selections >> /tmp/listaprogra.txt

if cat /tmp/listaprogra.txt | grep wmctrl >> /dev/null ;
then
  notify-send "no se necesito instalar wmctrl"
  else
    echo $pass | sudo -S ls /root && sudo apt-get- install wmctrl
    notify-send "instalado wmctrl"
    wmctrl  -r "./bios.sh" -b toggle,maximized_vert,maximized_horz
    exit
  fi

if cat /tmp/listaprogra.txt | grep glmark2 >> /dev/null ;
then
  notify-send "no se necesito instalar glmark2"
  else
    echo $pass | sudo -S ls /root && sudo apt-get- install glmark2
    notify-send "instalado glmark2"
  fi
wmctrl  -r "./bios.sh" -b toggle,maximized_vert,maximized_horz

# finaliza ravision de programas

echo $pass | sudo -S ls /root && sudo hwclock --hctosys # sincroniza la hora del sistema a la del BIOS



amixer sset Master  100% unmute & amixer sset Speaker  100% unmute & amixer sset PCM  100% unmute & amixer sset Headphone  100% unmute # sube volumen y quita el mute

#nohup gnome-terminal -x mplayer -shuffle /home/ghiatest/Música/*.mp3 # ejecuta mplayer en modo suffle en los tracks para prueba de audio
notify-send "Inicia la reproduccion"

sleep 2s;
/home/$ruta0/$ruta1/control_de_ventanas.sh
#gnome-terminal -e sh /home/ghiatest/rutinas/control_de_ventanas.sh # este eejecuta el siguiente Script
# fin de las rutinas
