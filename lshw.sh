#!/bin/bash
# -*- ENCODING: UTF-8 -*-

#descripcion - este bash hace un lshw sobre el hardware del equipo y ejecuta pruebas de Dico duro
#Author: Victor Ruben Farias Rolon
#creado 26 febrero 2016
#rev-0

#notas use el modo sudo -S para tomar la clave con echo

#inicio

ruta0=ghiatest
ruta1=rutinas
usb=series



notify-send "Inicia LSHW y busca llave OEM"

echo martha456 | sudo -S ls /root && sudo lshw -html > /home/$ruta0/pruebas/Hardware/Informe_de_Hardware.html
echo martha456 | sudo -S ls /root && sudo lshw -short > /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
echo martha456 | sudo -S ls /root && sudo lsblk -fm > /home/$ruta0/pruebas/particiones.txt
echo martha456 | sudo -S ls /root && sudo cat /sys/firmware/acpi/tables/MSDM* >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
echo martha456 | sudo -S ls /root && sudo ls -l /sys/firmware/acpi/tables >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
echo martha456 | sudo -S ls /root && sudo lsblk -fm >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
#termina la comprobacion
#inicia la condional que verfica que disco duro hay
if grep -q "sda" /home/$ruta0/pruebas/particiones.txt ;
then
  notify-send "Disco A"
  echo martha456 | sudo -S ls /root && sudo smartctl -s on /dev/sda
  echo martha456 | sudo -S ls /root && sudo smartctl -H /dev/sda >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
  echo martha456 | sudo -S ls /root && sudo smartctl --all /dev/sda > /home/$ruta0/pruebas/Hardware/DiscoA.txt
  echo martha456 | sudo -S ls /root && sudo smartctl -i /dev/sda > /home/$ruta0/pruebas/Hardware/InfoDiskA.txt
  echo martha456 | sudo -S ls /root && sudo hdparm -Tt /dev/sda > /home/$ruta0/pruebas/Hardware/RendimientoA.txt
else
  if grep -q "sdb" /home/$ruta0/pruebas/particiones.txt ;
  then
    notify-send "Disco B"
    echo martha456 | sudo -S ls /root && sudo smartctl -s on /dev/sdb
    echo martha456 | sudo -S ls /root && sudo smartctl -H /dev/sdb >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
    echo martha456 | sudo -S ls /root && sudo smartctl --all /dev/sdb > /home/$ruta0/pruebas/Hardware/DiscoB.txt
    echo martha456 | sudo -S ls /root && sudo smartctl -i /dev/sdb > /home/$ruta0/pruebas/Hardware/InfoDiskB.txt
    echo martha456 | sudo -S ls /root && sudo hdparm -Tt /dev/sdb > /home/$ruta0/pruebas/Hardware/RendimientoB.txt
  else
    if grep -q "sdc" /home/$ruta0/pruebas/particiones.txt ;
    then
      notify-send "Disco C"
      echo martha456 | sudo -S ls /root && sudo smartctl -s on /dev/sdc
      echo martha456 | sudo -S ls /root && sudo smartctl -H /dev/sdc >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
      echo martha456 | sudo -S ls /root && sudo smartctl --all /dev/sdd > /home/$ruta0/pruebas/Hardware/DiscoC.txt
      echo martha456 | sudo -S ls /root && sudo smartctl -i /dev/sdc > /home/$ruta0/pruebas/Hardware/InfoDiskC.txt
      echo martha456 | sudo -S ls /root && sudo hdparm -Tt /dev/sdc > /home/$ruta0/pruebas/Hardware/RendimientoC.txt
    else
      if grep -q "sdd" /home/$ruta0/pruebas/particiones.txt ;
      then
        notify-send "Disco D"
        echo martha456 | sudo -S ls /root && sudo smartctl -s on /dev/sdd
        echo martha456 | sudo -S ls /root && sudo smartctl -H /dev/sdd >> /home/$ruta0/pruebas/Hardware/Hardware_corto.txt
        echo martha456 | sudo -S ls /root && sudo smartctl --all /dev/sdd > /home/$ruta0/pruebas/Hardware/DiscoD.txt
        echo martha456 | sudo -S ls /root && sudo smartctl -i /dev/sdd > /home/$ruta0/pruebas/Hardware/InfoDiskD.txt
        echo martha456 | sudo -S ls /root && sudo hdparm -Tt /dev/sdd > /home/$ruta0/pruebas/Hardware/RendimientoD.txt
      else
        echo "naD"
      fi
      echo "naC"
    fi
    echo "naB"
  fi
  echo "naA"
fi
#termina la condional
sleep 2s;
notify-send "Abre Gedit"
nohup midori /home/$ruta0/pruebas/Hardware/Hardware_corto.txt &
sleep 4s;
#wmctrl -r "Hardware_corto.txt" -t 3
#wmctrl -r "Hardware_corto.txt" -e 0,300,150,900,900
wmctrl -r "file:///home/ghiatest/pruebas/Hardware/Hardware_corto.txt" -t 3
wmctrl -x -F -r "file:///home/ghiatest/pruebas/Hardware/Hardware_corto.txt" -e 0,300,150,600,600
wmctrl -s 3
#notify-send "Abre Midori con resultado de hardware"
#nohup gnome-terminal -x midori /home/$ruta0/pruebas/Hardware/Informe_de_Hardware.html &
sleep 1s;
#wmctrl -x -F -r "midori.Midori" -t0
sleep 3s;
notify-send "Se crea Switch"
touch /home/$ruta0/switch/switch.txt && echo "1" >> /home/$ruta0/switch/switch.txt
exit 0
#fin
