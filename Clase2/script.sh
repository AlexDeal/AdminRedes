#!/bin/bash

#Inicializamos las variables que vamos a utilizar
# n=0
# nombre=""
# apellido1=""
# apellido2=""
# arreglonombres=()
# arreglousuarios=()

#Funcion para leer los usuarios por nombre y apellidos.
agregar_usuarios () {
    clear
    read -p "Ingrese el numero de usuarios que quiere registar: " n
    for ((i=0; i<$n;i++)); do
        echo "Usuario numero: " $((i+1))
        echo "---------------------------------------------------"
        read -p "Ingrese el nombre: " nombre
        read -p "Ingrese el apellido paterno: " apellido1
        read -p "Ingrese el apellido materno: " apellido2
        nombrecompleto="$nombre $apellido1 $apellido2"
        read -a nombre <<< "$nombre"
        usuario="${nombre[0]}${apellido1:0:3}${apellido2:0:2}"
        usuario="${usuario,,}"
        usuario="${usuario^}"
        verificar_usuario
        arreglousuarios[$i]=$usuario
        arreglonombres[$i]=$nombrecompleto
        clear
    done
}

verificar_usuario () {
    j=0
    for us in ${arreglousuarios[*]}; do
        if [[ "$us" == *"$usuario"* ]]; then
            echo "El usuario existe"
            j=$((j+1))
        fi
    done
    if [ $j -gt 0 ] ; then
        usuario="${usuario}$j"
    fi
}

#Funcion para mostrar todos los usuarios
mostrar_usuarios () {
    clear
    for ((i=0;i<$n;i++)); do
        echo "Usuario $((i+1))"
        echo "-----------------------------------------------------------------"
        echo "Nombre: ${arreglonombres[i]}"
        echo "Usuario: ${arreglousuarios[i]}"
        echo
        #sudo useradd -m ${arreglousuarios[i],,}
    done
    read -p "Presiona una tecla para continuar" opcion1
}

while : ;do
    clear
    echo "  █████╗ ██████╗ ██████╗     ██╗   ██╗███████╗███████╗██████╗ ███████╗    "
    echo " ██╔══██╗██╔══██╗██╔══██╗    ██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝    "
    echo " ███████║██║  ██║██║  ██║    ██║   ██║███████╗█████╗  ██████╔╝███████╗    "
    echo " ██╔══██║██║  ██║██║  ██║    ██║   ██║╚════██║██╔══╝  ██╔══██╗╚════██║    "
    echo " ██║  ██║██████╔╝██████╔╝    ╚██████╔╝███████║███████╗██║  ██║███████║    "
    echo " ╚═╝  ╚═╝╚═════╝ ╚═════╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝    "

    echo "1.- Agregar usuarios"                                                                         
    echo "2.- Mostrar usuarios creados"
    echo "3.- Salir"

    read -p "Ingrese una opcion [1-3]: " opcion

    case $opcion in
        1) agregar_usuarios;;
        2) mostrar_usuarios;;
        3) echo "Adios"
           exit 0;;
    esac
done
