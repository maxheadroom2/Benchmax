#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0

###############################################################################
# descripcion: Scritp madre que cambia de Area de trabajo y los captura y     #
# llama a otros scripts hijos.                                                #
###############################################################################

# LISTADO DE PROCESOS ----------------------------------------------------------
# snap-photobooth < Web cam
# gnome-terminal  < Terminal de gnome
# wmctrl          < Gestor de ventanas
# glmark2         < Pruebas de video0
# midori          < Explorador Web
# scrot           < Captura areas de trabajo
# LISTADO DE SCRIPTS HIJOS -----------------------------------------------------
# /home/$ruta0/lshw.sh        < ejecuta pruebas de Hardware y HD
# /home/$ruta0/sonido.sh      < ejecuta prueba de audio
################################################################################

# Inicio de dialog y Scrpit#####################################################

ruta0=ghiatest
ruta1=rutinas


WHILE=0

while [ $CONTROL=0 ]; do
  df | grep SDCARD >> /dev/null

  if [ $? -ne 1 ];
  then

    sleep 2s;
    notify-send "Sd Card Insertada con exito! espera que termine la captura"
    wmctrl -s 6
    sleep 2s;
    exo-open --launch FileManager
    sleep 2s;
    scrot -m  /home/$ruta0/pruebas/SDCARD.png
    notify-send "Terminado ya puedes crear la serie la serie"
    cd /home/$ruta0
    zip -r SDCARD.zip pruebas*
    notify-send "Zip creado en la Ruta /home/$ruta0/SDCARD.zip"
    wmctrl -s 0
    exit
  else
    notify-send " !!!! No has Insertado la SD card"
  fi
  sleep 2s
done
