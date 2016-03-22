#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0

ruta0=ghiatest
ruta1=rutinas
usb=series
nombre=demofinal


#---------- inicia integridad ----- archivos -------
notify-send "verificando archivos e integridad"


hash1= sha1sum /home/$ruta0/SDCARD.zip
hash2= sha1sum /home/$ruta0/Pruebas_de_equipo.zip
hashusb1= sha1sum /media/$ruta0/$usb/$nombre/SDCARD.zip
hashusb2= sha1sum /media/$ruta0/$usb/$nombre/Pruebas_de_equipo.zip

notify-send "Se hizo la copia con exito en la Memoria USB SERIES    se procedera a desmontar la memoria"

WHILE=0

while [ $CONTROL=0 ] ; do

if [ $hash1 = $hashusb1 ];
then
  notify-send "SDCARD.zip OK"

  echo "$hash1"
  echo "$hashusb1"
  echo "$hash2"
  echo "$hashusb2"

  WHILE=0

  while [ $CONTROL=0 ] ; do
    if [ $hash2 = $hashusb2 ];
    then
      notify-send "Pruebas_de_equipo.zip OK"
      exit
      echo martha456 | sudo -S ls /root && sudo poweroff
    else
      hash2= sha1sum /home/$ruta0/Pruebas_de_equipo.zip
      hashusb2= sha1sum /media/$ruta0/$usb/$nombre/Pruebas_de_equipo.zip
    fi
  done
else
  hash1= sha1sum /home/$ruta0/SDCARD.zip
  hashusb1= sha1sum /media/$ruta0/$usb/$nombre/SDCARD.zip
  fi
  sleep 1s;
done
# ----------- fin de revision archivos integridad ----
