#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolon
# creado 26 febrero 2016
# rev-0

###############################################################################
# descripcion: Scritp hijo en el cual ejecuta el menu con Dialog en el cual al#
# insertar la memoria USB el sistema lo ejecutara.                            #
###############################################################################

# LISTADO DE PROCESOS ----------------------------------------------------------
# wmctrl          < Gestor de ventanas
# LISTADO DE SCRIPTS HIJOS -----------------------------------------------------
#
#
################################################################################

# Inicio de scritp #############################################################

ruta0=ghiatest
ruta1=rutinas
usb=series

wmctrl -F -r "./menu.sh" -e 200,500,90,700,700
wmctrl -F -r "./menu.sh" -t 5
wmctrl -F -r "./menu.sh" -e 200,500,90,700,700
wmctrl -s 5

wmctrl -F -r "Terminal" -e 200,500,90,700,700
wmctrl -F -r "Terminal" -t 5
wmctrl -F -r "Terminal" -e 200,500,90,700,700
wmctrl -s 5

cd /home/$ruta0/switch
rm * 2>/dev/null

if df | grep $usb >> /dev/null ; # verifica si esta la memoria USB -----
then
  wmctrl -F -r "./menu.sh" -e 200,500,90,700,700
  wmctrl -F -r "./menu.sh" -t 5
  wmctrl -F -r "./menu.sh" -e 200,500,90,700,700

  cmd=(dialog --separate-output --nocancel --checklist "Ingresa La Serie:" 22 76 16)
  options=(1 "Ingresa la serie" on
           2 "Repite las pruebas" off
           3 "Apagar el Equipo" off
           4 "Borra las pruebas"  off
           5 "Acerca del Sistema de Pruebas" off)    #  "on" selecciona
  choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
  clear
  for choice in $choices
  do
      case $choice in
          1) #---------------------------------------------------------------------------------------------------------------------------------
              dialog --title "Desarrollado por" --msgbox "
        _  ______  __  ____________ _____________  _
        |\/||__| \/ |__||___|__||  \|__/|  ||  ||\/|
        |  ||  |_/\_|  ||___|  ||__/|  \|__||__||  |

       ---------------------------------------------
            Victor Ruben Farias Rolon 2016 rev-0

                Telegram Alias @maxheadroom2

                        |\/\/\/\/\|
                        |---------|
                        |---------|
                        |----(¬) (¬)
                        C---------__)
                        |   ,_____)
                        |  /\/\/\/
                        |  /\/\/)
                        |------/
                       /_______\,
                      /_________\.


              " 60 60
             #---------------------------------------- Dialogo de entrada de serie
              serie="/tmp/texto.txt"
              dialog --title "" --backtitle "Victor Ruben Farias Rolon" \
              --inputbox "Ingresa la Serie del Equipo: " 8 60 2>"${serie}"
              sel=$?
              nombre=`cat /tmp/texto.txt`
              case $sel in
                0) dialog --backtitle "Victor Ruben Farias Rolon" --title "Se creo una carpeta" --msgbox "se procedera a copiar la carpeta de pruebas dentro de la carpeta $nombre cuya ruta es /home/$ruta0/$nombre"  7 70;;
                1) clear; exit 0;;
              esac
              rm -f /tmp/texto.txt
              # -----------------------------------fin de dialogo entrada de serie
              mkdir /home/$ruta0/$nombre
              cp -a /home/$ruta0/*.zip /home/$ruta0/$nombre
              cp -a /home/$ruta0/$nombre /media/$ruta0/$usb
              sleep 6s;
              notify-send "verificando archivos e integridad"


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
                    #exit
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

              response=$?
              case $response in
              esac
              ;;
          2) #---------------------------------------------------------------------------------------------------------------------------------
              /home/$ruta0/$ruta1/control_de_ventanas.sh
              ;;
          3) #---------------------------------------------------------------------------------------------------------------------------------
              echo martha456 | sudo -S ls /root && sudo poweroff
              ;;
          4)
              cd /home/$ruta0/pruebas/Hardware
              rm *
              cd /home/$ruta0/pruebas
              rm *
              rm -r /home/$ruta0/Pruebas_de_equipo.zip
              rm -r /home/$ruta0/nohup.out
              notify-send "borrado completo"
              /home/$ruta0/$ruta1/menu.sh
              ;;
          5)
          dialog --title "Desarrollado por" --msgbox "
    _  ______  __  ____________ _____________  _
    |\/||__| \/ |__||___|__||  \|__/|  ||  ||\/|
    |  ||  |_/\_|  ||___|  ||__/|  \|__||__||  |

   ---------------------------------------------
        Victor Ruben Farias Rolon 2016 rev-0

            Telegram Alias @maxheadroom2

                    |\/\/\/\/\|
                    |---------|
                    |---------|
                    |----(¬) (¬)
                    C---------__)
                    |   ,_____)
                    |  /\/\/\/
                    |  /\/\/)
                    |------/
                   /_______\,
                  /_________\.


          " 60 60

              ;;
      esac
  done
else #--------------------------------------------------- condional de la USB ---------------------
  dialog --title "Hay un problema no has Abierto la USB" --msgbox "Inserta y Abre la Memoria USB de Series, ya que el sistema no lo monta por que al no tener un perfil de Hardware Definido no se puede montar en automatico,

El sistema te abrira la ventana y solo dale clic a la memoria USB series (ENTER PARA CONTINUAR)" 20 60
  exo-open --launch FileManager && killall gnome-terminal
fi #----------------------------------------------------- fin condional de la USB -----------------
exit 0
