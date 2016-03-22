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
usb=series


wmctrl -s 5
wmctrl -F -r "./usb.sh" -e 200,500,90,700,700
wmctrl -F -r "./usb.sh" -t 5
wmctrl -F -r "./usb.sh" -e 200,500,90,700,700

WHILE=0

while [ $CONTROL=0 ] ; do
  df | grep $usb >> /dev/null

  if [ $? -ne 1 ];
  then
    dialog --backtitle "Inserto de memoria USB" --title "Se te redirecionara al menu de la memoria para que puedas copiar la informacion a la USB" --infobox "

                  |\/\/\/\/\|
                  |---------|
                  |---------|
                  |----(o) (0)
                 C---------__)
                  |  ,_____)
                  |------/
                 /_______\,
                /_________\.

Todas las pruebas Fueron Realizadas con Exito!!
     " 25 50
    sleep 1s;
    notify-send "

                        |\/\/\/\/\/\|
                        |-----------|
                        |-----------|
                        |----(o) (0)
                       C---------__)
                        |  ,_____)
                        |--------/   SEGUIMOS !!!!
                       /_______\,
                      /_________\.

    Todas las pruebas Fueron Realizadas con Exito!!
     "
    gnome-terminal -e /home/$ruta0/$ruta1/menu.sh
    nohup midori /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
    wmctrl -r "file:///home/ghiatest/pruebas/Hardware/Hardware_corto.txt" -t 0
    wmctrl -s 0
    exit
  else
    notify-send "

                        |\/\/\/\/\/\|
                        |-----------|
                        |-----------|
                        |----(o) (0)
                       C---------__)
                        |  ,_____)
                        |--------/   SEGUIMOS !!!!
                       /_______\,
                      /_________\.

    Inserta la USB series!!
     "
  fi
  sleep 1s
done
