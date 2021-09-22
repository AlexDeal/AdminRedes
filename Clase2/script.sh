#!/bin/bash

n=0
nombre=""
apellido1=""
apellido2=""
arreglonombres=()
arreglousuarios=()


#Leemos el nombre completo de cada usuario
read -p "Ingrese el numero de usuarios que quiere registar: " n
for ((i=0; i<$n;i++)); do
    read -p "Ingrese el nombre: " nombre
    read -p "Ingrese el apellido 1: " apellido1
    read -p "Ingrese el apellido 2: " apellido2
    nombrecompleto="$nombre $apellido1 $apellido2"
    read -a nombre <<< "$nombre"
    usuario="${nombre[0]}${apellido1:0:3}${apellido2:0:2}"
    usuario="${usuario,,}"
    usuario="${usuario^}"
    arreglousuarios[$i]=$usuario
    arreglonombres[$i]=$nombrecompleto
done

for ((i=0;i<$n;i++)); do
    echo "El nombre completo del usuario ${i+1} es: ${arreglonombres[i]}"
    echo "El nombre del usuario ${i+1} es: ${arreglousuarios[i]}"
    sudo useradd -m ${arreglousuarios[i],,}
done


# i=1
# for usuario in "${arreglonombres[@]}"; do
#     echo "El nombre completo del usuario $i es: $usuario"
#     i=$((i+1))
# done
# i=1
# for usuario in "${arreglousuarios[@]}"; do
#     echo "El nombre del usuario $i es: $usuario"
#     i=$((i+1))
# done

