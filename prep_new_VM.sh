#!/bin/bash

wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
echo "kali" | sudo apt install ./vscode.deb
sudo -S apt update
sudo apt install terminator -y
sudo apt install pwncat -y
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
