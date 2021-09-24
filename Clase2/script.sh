#!/bin/bash

# Programa que pide un numero n, para crear usuarios basados en el nombre y apellidos
# El nombre de usuario se crear a partir de las 3 primeras letras del nombre, las 3 del apellido paterno
# y 2 letras del apellido materno.
# Por ejemplo: Con el nombre Jesus Alejandro Serrano Morales tenemos el nombre de usuario: Jessermo
# En el caso de que el usuario ya exista, se agrega un numero al final del usuario.
# Por ejemplo en el caso de que el usuario anterior exista, entonces el nuevo usuario seria: Jessermo1


# Funcion para leer los usuarios por nombre y apellidos.
agregar_usuarios () {
    clear
    for ((i=0; i<$n;i++)); do
        echo "Usuario numero: " $((i+1))
        echo "---------------------------------------------------"
        read -p "Ingrese el nombre: " nombre
        nombre="${nombre^}"
        read -p "Ingrese el apellido paterno: " apellido1
        apellido1="${apellido1^}"
        read -p "Ingrese el apellido materno: " apellido2
        apellido2="${apellido2^}"
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

# Con esta funcion verificamos que el usuario no exista y en dado de que exista se agregará un numero al nombre de usuario
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

# Funcion para mostrar todos los usuarios
mostrar_usuarios () {
    clear
    for ((i=0;i<$n;i++)); do
        echo "Usuario $((i+1))"
        echo "-----------------------------------------------------------------"
        echo "Nombre: ${arreglonombres[i]}"
        echo "Usuario: ${arreglousuarios[i]}"
        echo
        # Descomentar la linea siguiente para agregar los usuarios
        #sudo useradd -m ${arreglousuarios[i],,}
    done
    read -p "Presiona una tecla para continuar" opcion1
}


clear
echo "  █████╗ ██████╗ ██████╗     ██╗   ██╗███████╗███████╗██████╗ ███████╗    "
echo " ██╔══██╗██╔══██╗██╔══██╗    ██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝    "
echo " ███████║██║  ██║██║  ██║    ██║   ██║███████╗█████╗  ██████╔╝███████╗    "
echo " ██╔══██║██║  ██║██║  ██║    ██║   ██║╚════██║██╔══╝  ██╔══██╗╚════██║    "
echo " ██║  ██║██████╔╝██████╔╝    ╚██████╔╝███████║███████╗██║  ██║███████║    "
echo " ╚═╝  ╚═╝╚═════╝ ╚═════╝      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝    "

while [[ ! $n =~ ^[1-9] ]]; do
    echo Ingrese el numero de usuarios a registar
    read n
done

agregar_usuarios
mostrar_usuarios