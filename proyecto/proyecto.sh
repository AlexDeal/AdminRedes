#!/bin/bash

#Funciones
crearContraseña(){
    #sudo -S sed -i 's/sha512/sha512 minline=12/g' /etc/pam.d/common-password
    echo "Longitud modificada exitosamente"
    read -p "Ingrese el nombre del usuario al que le quiere cambiar la contraseña: " nombre
    ead -p "Ingrese la nueva contraseña: " pass
    su $nombre
}

crearUsuario(){
    read -p "Ingrese el nombre del usuario" nombre
    sudo -S adduser $nombre
    getent passwd | grep $nombre
}

crearArchivo(){
    read -p "Ingrese el id del usuario" id
    cat /var/log/syslog | grep $id >> /home/alex/Escritorio/acciones.txt
}

accesosFallidos(){
    read -p "Ingrese el usuario del usuario" usuario
    faillog -u $usuario
}

accesoTecnicos(){
    read -p "Ingrese el nombre del usuario" nombre
    sudo -S adduser $nombre
    usermod -G admin $nombre
    read -p "Ingrese el nombre del usuario" nombre
    sudo -S adduser $nombre
    usermod -G admin $nombre
}

deshabilitarServicio(){
    #Falta codigo para permitir ingresar a la sesion del tecnico
    sudo systemctl list-unit-files --type service --all
    read -p "Ingrese el nombre del servicio que deseas detener" servicio
    sudo -S systemctl disable $servicio
}

clear
echo "██████╗ ██████╗  ██████╗ ██╗   ██╗███████╗ ██████╗████████╗ ██████╗ "
echo "██╔══██╗██╔══██╗██╔═══██╗╚██╗ ██╔╝██╔════╝██╔════╝╚══██╔══╝██╔═══██╗"
echo "██████╔╝██████╔╝██║   ██║ ╚████╔╝ █████╗  ██║        ██║   ██║   ██║"
echo "██╔═══╝ ██╔══██╗██║   ██║  ╚██╔╝  ██╔══╝  ██║        ██║   ██║   ██║"
echo "██║     ██║  ██║╚██████╔╝   ██║   ███████╗╚██████╗   ██║   ╚██████╔╝"
echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ "
                                                                    
while [[ ! $opcion =~ ^[1-9] ]]; do
    echo "1.- Establecer longitud minima de 12 caracteres a las contraseñas"
    echo "2.- Crear usuarios de acuerdo a las normas y visualizar informacion"
    echo "3.- Mandar un archivo con las ultimas acciones de un usuario"
    echo "4.- Ver todos los usuarios que han intentado entrar al servidor con contraseña erronea"
    echo "5.- Crear cuentas para tecnicos de soporte"
    echo "6.- Mostras los servicios activos del sistema y deshabilitar servicios"
    echo "7.- DMostrar bitacoras"
    read -p "Ingrese una opcion [1-7] " opcion

    case $opcion in
        1)  crearContraseña
            sleep 3;;
        2)  crearUsuario
            sleep 3;;
        3)  crearArchivo
            sleep 3;;
        4)  accesosFallidos
            sleep 3;;
        5)  accesoTecnicos
            sleep 3;;
        6) deshabilitarServicio
            sleep 3;;
        7) echo "Adios"
            exit 0;;
        *) echo "Opcion no reconocida"
    esac
done