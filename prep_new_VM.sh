#!/bin/bash

wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
echo "kali" | sudo apt install ./vscode.deb
sudo -S apt update
sudo apt install terminator -y
sudo apt install python3-pip
pip install git+https://github.com/calebstewart/pwncat.git
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
