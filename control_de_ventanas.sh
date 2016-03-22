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

# Inicio de dialog #############################################################

echo martha456 | sudo -S ls /root && sudo hwclock --hctosys
ruta0=ghiatest
ruta1=rutinas
usb=series

wmctrl -F -r "./control_de_ventanas.sh" -e 200,500,90,700,700
wmctrl -F -r "./control_de_ventanas.sh" -t 5
wmctrl -F -r "./control_de_ventanas.sh" -e 200,500,90,700,700

dialog --backtitle "Scrpt Diseñado por Victor Ruben Farias Rolon" --title "Infomacion del script" --infobox "
#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0

###############################################################################
descripcion: Scritp madre que cambia de Area de trabajo y los captura y
llama a otros scripts hijos.
###############################################################################

# LISTADO DE PROCESOS ----------------------------------------------------------
# snap-photobooth < Web cam
# gnome-terminal  < Terminal de gnome
# wmctrl          < Gestor de ventanas
# glmark2         < Pruebas de video0
# midori          < Explorador Web
# scrot           < Captura areas de trabajo
# nohup           < Ejecutar demonios sin estar arraigados a la terminal
" 30 60
sleep 3s;
clear;

# inicio de Script ###################################################################

# verifica si esta la carpeta Hardware -----------------------------------------------
if ls  /home/$ruta0/pruebas/ | grep Hardware >> /dev/null ;
then
  echo "ya existia no se creo nada"
else
  mkdir /home/$ruta0/pruebas/Hardware
fi
# ------------------------------------------------------------------------------------
# Verifica si hay Web Cam montada ----------------------------------------------------
if ls /dev/video* -lh | grep "video0" >> /dev/null ;
then
  nohup snap-photobooth &
  sleep 1
  nohup glmark2 &
  sleep 1
  nohup /home/$ruta0/$ruta1/lshw.sh &
else
  nohup glmark2 &
  nohup /home/$ruta0/$ruta1/lshw.sh &
fi
# ------------------------------------------------------------------------------------
# switch de inicio en espera, lo manda lshw ------------------------------------------

WHILE=0

while [ $CONTROL=0 ] ; do
  cat /home/$ruta0/switch/switch.txt | grep 1 >> /dev/null
  if [ $? -ne 1 ];
  then
    CONTADOR=0
    # inicia acomodo de las ventanas
    notify-send "lshw termino"
    wmctrl -r "glmark2 2012.08" -t2
    wmctrl -r "glmark2 2012.08" -e 0,300,150,600,600
    wmctrl -x -F -r "snap-photobooth.Snap-photobooth" -t 1
    wmctrl -x -F -r "snap-photobooth.Snap-photobooth" -e 0,300,150,600,600
    #wmctrl -x -F -r "midori4.Midori" -t 0
    notify-send "inicia espera 10 segundos"
    sleep 10s;
    # Inicia las capturas de pantalla---------------------------------------------
    wmctrl -s 0
    notify-send "Area de Trabajo 0"
    sleep 2s;
    notify-send "cap"
    scrot -m  /home/$ruta0/pruebas/monitor0.png
    sleep 1s;
    wmctrl -s 1
    notify-send "Area de Trabajo 1"
    sleep 2s;
    notify-send "cap"
    scrot -m  /home/$ruta0/pruebas/monitor1.png
    sleep 1s;
    # Se queda en el mismo monitor para hacer la captura dos veces ---------------
    wmctrl -s 2
    notify-send "Area de Trabajo 2"
    sleep 2s;
    notify-send "cap"
    scrot -m  /home/$ruta0/pruebas/monitor2.png
    sleep 1s;
    notify-send "cap 2"
    scrot -m  /home/$ruta0/pruebas/monitor2b.png
    notify-send "Area de Trabajo 2 segunda captura"
    sleep 1s;
    # ----------- fin doble captura de monitor -----------------------------------
    wmctrl -s 3
    notify-send "Area de Trabajo 3"
    sleep 2s;
    notify-send "cap"
    scrot -m  /home/$ruta0/pruebas/monitor3.png
    sleep 1s;
    wmctrl -s 4
    notify-send "Area de Trabajo 4"
    sleep 2s;
    notify-send "cap"
    scrot -m  /home/$ruta0/pruebas/monitor4.png
    sleep 1s;

    # ------------ fin capturas de pantalla ---------------------------------------
    notify-send "Borra Switch para poder hacer prueba de nuevo"
    cd /home/$ruta0/switch
    rm * 2>/dev/null

    dialog --backtitle "Scrpt Diseñado por Victor Ruben Farias Rolon" --title "Prueba Finalizada" --infobox "Se generara un zip de las pruebas estas no tienen serie el archivo se llama (Pruebas de equipo)" 20 60
    cd /home/$ruta0
    zip -r Pruebas_de_equipo.zip pruebas*
    notify-send "Zip creado en la Ruta /home/$ruta0/Pruebas_de_equipo.zip"
    sleep 2s;
    wmctrl -s 5
    gnome-terminal -e /home/$ruta0/$ruta1/usb.sh
    gnome-terminal -e /home/$ruta0/$ruta1/sd.sh
    exit
    #killall gnome-terminal

  else
    CONTADOR=1
    wmctrl -r "glmark2 2012.08" -t2
    wmctrl -r "glmark2 2012.08" -e 0,300,150,600,600
    wmctrl -x -F -r "snap-photobooth.Snap-photobooth" -t 1
    wmctrl -x -F -r "snap-photobooth.Snap-photobooth" -e 0,300,150,600,600
    wmctrl -x -F -r "midori4.Midori" -t 0
    wmctrl -x -F -r "scratch-text-editor.Scratch-text-editor" -t 3
    echo -ne "esta en espera de que termine lshw su proceso =| "
    echo -ne "esta en espera de que termine lshw su proceso =) "
    echo -ne "esta en espera de que termine lshw su proceso ¬¬ "
    echo -ne "esta en espera de que termine lshw su proceso ^^ "

  fi
  sleep 1
  done
