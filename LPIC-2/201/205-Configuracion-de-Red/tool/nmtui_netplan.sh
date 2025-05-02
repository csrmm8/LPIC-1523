#!/bin/bash
# Script en bash con ncurses para configurar netplan similar a nmtui

# Verificar si se ejecuta como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ejecutarse con privilegios de root" 
   exit 1
fi

# Verificar si dialog está instalado
if ! command -v dialog &> /dev/null; then
    echo "dialog no está instalado. Instalándolo..."
    apt-get update && apt-get install -y dialog
fi

# Ruta del archivo de configuración de netplan
NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"

# Función para mostrar menú principal
main_menu() {
    while true; do
        exec 3>&1
        selection=$(dialog \
            --backtitle "Configurador Netplan con NCURSES" \
            --title "Menú Principal" \
            --clear \
            --cancel-label "Salir" \
            --menu "Selecciona una opción:" \
            15 40 4 \
            1 "Configurar Interfaz" \
            2 "Aplicar Configuración" \
            3 "Ver Configuración Actual" \
            2>&1 1>&3)
        exit_status=$?
        exec 3>&-
        if [ $exit_status != 0 ]; then
            clear
            echo "Saliendo del programa..."
            break
        fi
        case $selection in
            1) configure_interface ;;
            2) apply_configuration ;;
            3) show_configuration ;;
        esac
    done
}

# Función para configurar interfaz
configure_interface() {
    interfaces=($(ls /sys/class/net 2>/dev/null))
    interface_options=()
    for iface in "${interfaces[@]}"; do
        interface_options+=("$iface" "Desconocido")
    done

    exec 3>&1
    selected_iface=$(dialog \
        --backtitle "Configurador Netplan" \
        --title "Selecciona Interfaz" \
        --radiolist "Elige la interfaz a configurar:" \
        15 40 6 \
        "${interface_options[@]}" \
        2>&1 1>&3)
    exec 3>&-

    if [ -z "$selected_iface" ]; then
        dialog --msgbox "No se seleccionó ninguna interfaz." 5 40
        return
    fi

    exec 3>&1
    ip_config=$(dialog \
        --inputbox "Ingresa IP (ej: 192.168.1.10/24):" 8 40 \
        2>&1 1>&3)
    exec 3>&-

    exec 3>&1
    gateway_config=$(dialog \
        --inputbox "Ingresa Gateway (ej: 192.168.1.1):" 8 40 \
        2>&1 1>&3)
    exec 3>&-

    exec 3>&1
    dns_config=$(dialog \
        --inputbox "Ingresa DNS (ej: 8.8.8.8, 8.8.4.4):" 8 40 \
        2>&1 1>&3)
    exec 3>&-

    create_netplan_config "$selected_iface" "$ip_config" "$gateway_config" "$dns_config"
}

# Función para crear el archivo YAML de netplan
create_netplan_config() {
    local iface="$1"
    local ip="$2"
    local gw="$3"
    local dns="$4"

    echo "network:" > "$NETPLAN_CONFIG"
    echo "  version: 2" >> "$NETPLAN_CONFIG"
    echo "  ethernets:" >> "$NETPLAN_CONFIG"
    echo "    $iface:" >> "$NETPLAN_CONFIG"
    echo "      dhcp4: no" >> "$NETPLAN_CONFIG"
    echo "      addresses:" >> "$NETPLAN_CONFIG"
    echo "        - $ip" >> "$NETPLAN_CONFIG"
    echo "      gateway4: $gw" >> "$NETPLAN_CONFIG"
    echo "      nameservers:" >> "$NETPLAN_CONFIG"
    echo "        addresses: [$dns]" >> "$NETPLAN_CONFIG"

    dialog --msgbox "Configuración guardada en $NETPLAN_CONFIG" 6 50
}

# Función para aplicar configuración
apply_configuration() {
    if [ ! -f "$NETPLAN_CONFIG" ]; then
        dialog --msgbox "No existe archivo de configuración. Crea uno primero." 5 50
        return
    fi

    output=$(netplan try 2>&1)
    if [ $? -eq 0 ]; then
        dialog --msgbox "Configuración aplicada correctamente." 5 50
    else
        dialog --msgbox "Error al aplicar configuración:\n$output" 10 60
    fi
}

# Función para ver configuración actual
show_configuration() {
    if [ -f "$NETPLAN_CONFIG" ]; then
        config_content=$(cat "$NETPLAN_CONFIG")
        echo "$config_content" | dialog --programbox 20 70
    else
        dialog --msgbox "No hay archivo de configuración creado." 5 50
    fi
}

# Iniciar el menú principal
main_menu