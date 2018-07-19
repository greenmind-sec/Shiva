#!/bin/bash

function add_new_message() {
    # Saudação linux
    NEW_MSG = "ShivaLinux init version \n Using Debian Stretch \n Debian is Love s2"
    mv /etc/motd /etc/motd-BKP
    echo $NEW_MSG > /etc/motd
}

function modify_image_grub() {
    # GRUB
    mv /usr/share/images/desktop-base/desktop-grub.png /usr/share/images/desktop-base/desktop-grub-BKP.png
    mv grub.jpg /usr/share/images/desktop-base/desktop-grub.png
}

function modify_image_login() {
    # Login
    mv /usr/share/images/desktop-base/login-background.svg /usr/share/images/desktop-base/login-background-BKP.svg
    mv login.svg /usr/share/images/desktop-base/login-background.svg
}

function modify_image_desktop() {
    # Area de trabalho
    mv /usr/share/images/desktop-base/desktop-background /usr/share/images/desktop-base/desktop-background-BKP
    mv /usr/share/images/desktop-base/default /usr/share/images/desktop-base/default-BKP
    mv lord-shiva.png /usr/share/images/desktop-base/desktop-background
    cp /usr/share/images/desktop-base/desktop-background /usr/share/images/desktop-base/default
}

function add_virtualbox() {
    # Virtualbox
    apt-add-repository 'deb https://download.virtualbox.org/virtualbox/debian stretch contrib'
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    apt-get update
    apt-get install virtualbox-5.0 -y
    wget https://download.virtualbox.org/virtualbox/5.0.40/Oracle_VM_VirtualBox_Extension_Pack-5.0.40.vbox-extpack
    VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-5.0.40.vbox-extpack
}

function add_docker() {
    # Docker
    apt-get update
    apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    apt-get update
    apt-get install docker-ce -y
    apt-get install docker-compose -y
}

function add_shiva_requirements() {
    # ADD Python
    apt-get install python3 -y
    apt-get install python3-pip -y
    apt-get install git -y
    pip3 install docker
}

function add_shiva() {
    #Download Shiva
    cd /tmp && git clone https://github.com/greenmind-sec/Shiva && mv Shiva /opt/Shiva
    chmod +x /opt/Shiva/shiva.py
    cp /opt/Shiva/shiva.py /bin/shiva
    chmod +x /bin/shiva
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#ADD new message /etc/motd
add_new_message

#Modify image grub
modify_image_grub

#Modify image login
modify_image_login

#Modify image desktop
modify_image_desktop

#ADD virtualbox
add_virtualbox

#ADD docker
add_docker

#ADD shiva requirements
add_shiva_requirements

#ADD Shiva
add_shiva