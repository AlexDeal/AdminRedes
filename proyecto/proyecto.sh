#!/bin/bash

#Funciones
crearContraseña(){
    echo ""
    if grep -q "sha512 minlen=12" /etc/pam.d/common-password; then
        echo "Existe longitud minima y es de 12"
    else
        sudo -S sed -i 's/sha512/sha512 minlen=12/g' /etc/pam.d/common-password
        echo "Longitud modificada exitosamente"
    fi
}

crearUsuario(){
    echo ""
    read -p "Ingrese el nombre del usuario: " nombre
    sudo -S adduser $nombre
    cat /etc/passwd | grep $nombre
}

crearArchivo(){
    echo ""
    read -p "Ingrese el id del usuario: " id

    if id -nu "$id" > /dev/null; then
        sudo -s cat /var/log/syslog | grep uid=$id | tee /home/$(whoami)/Escritorio/acciones.txt
        echo "Operación completada con éxito"
    fi
}

accesosFallidos(){
    echo ""
    cat /var/log/auth.log | grep 'authentication failure'
}

accesoTecnicos(){
    echo ""
    read -p "Ingrese el nombre de usuario del técnico 1: " nombre
    sudo -S adduser $nombre
    usermod -aG adm $nombre
    usermod -aG Tecnicos $nombre
    usermod -aG sudo $nombre
    echo ""
    read -p "Ingrese el nombre de usuario del técnico 2: " nombre
    sudo -S adduser $nombre
    usermod -aG adm $nombre
    usermod -aG Tecnicos $nombre
    usermod -aG sudo $nombre
}

deshabilitarServicio(){
    echo ""
    read -p "Ingrese el nombre del usuario: " tecnico
    if grep -q $tecnico /etc/group; then
        systemctl list-unit-files --type service --all
        read -p "Ingrese el nombre del servicio que deseas detener: " servicio
        su - $tecnico -c "sudo -S systemctl stop $servicio"
        systemctl status $servicio | grep Active
    else
        echo "El usuario no es tecnico"
    fi
}

                                                                    
while [[ ! $opcion =~ 8 ]]; do
    clear
    echo "██████╗ ██████╗  ██████╗ ██╗   ██╗███████╗ ██████╗████████╗ ██████╗ "
    echo "██╔══██╗██╔══██╗██╔═══██╗╚██╗ ██╔╝██╔════╝██╔════╝╚══██╔══╝██╔═══██╗"
    echo "██████╔╝██████╔╝██║   ██║ ╚████╔╝ █████╗  ██║        ██║   ██║   ██║"
    echo "██╔═══╝ ██╔══██╗██║   ██║  ╚██╔╝  ██╔══╝  ██║        ██║   ██║   ██║"
    echo "██║     ██║  ██║╚██████╔╝   ██║   ███████╗╚██████╗   ██║   ╚██████╔╝"
    echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ "
    echo ""
    echo "1.- Establecer longitud minima de 12 caracteres a las contraseñas"
    echo "2.- Crear usuarios de acuerdo a las normas y visualizar informacion"
    echo "3.- Mandar un archivo con las ultimas acciones de un usuario"
    echo "4.- Ver todos los usuarios que han intentado entrar al servidor con contraseña erronea"
    echo "5.- Crear cuentas para tecnicos de soporte"
    echo "6.- Mostras los servicios activos del sistema y deshabilitar servicios"
    echo "7.- Mostrar bitacoras"
    echo "8.- Salir"
    echo ""
    read -p "Ingrese una opcion [1-8]: " opcion

    case $opcion in
        1)  crearContraseña;;
        2)  crearUsuario ;;
        3)  crearArchivo ;;
        4)  accesosFallidos ;;
        5)  accesoTecnicos ;;
        6) deshabilitarServicio ;;
        7) echo "Adios"
            exit 0;;
        8) echo "Adios"
            exit 0;;
        *) echo "Opción no válida"
    esac
    read -p "Presione enter para continuar" enter
done
