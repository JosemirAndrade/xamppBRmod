#!/bin/bash

pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY bash -c '
wget http://www.sis4.com/brModelo/brModelo.jar
sudo mkdir /opt/brModelo
sudo chmod +s /opt/brModelo
sudo chmod 777 /opt/brModelo
sudo cp /home/aluno/brModelo.jar /opt/brModelo/

curl -o ~/brModelo.png -OL https://github.com/chcandido/brModelo/raw/master/src/imagens/logico.png
sudo mv ~/brModelo.png /opt/brModelo

tee /home/$USER/Área\ de\ Trabalho/brmodelo.desktop <<EOF
[Desktop Entry]
Version=3.2
Name=brModelo
Exec=java -jar /opt/brModelo/brModelo.jar
Icon=/opt/brModelo/brModelo.png
Type=Application
Comment=The software for MER
Path=/opt/brModelo
Terminal=false
StartupNotify=true
Categories=Development;Education;
EOF

wget "https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/7.4.27/xampp-linux-x64-7.4.27-2-installer.run/download" -O xampp-installer.run && chmod +x xampp-installer.run && ./xampp-installer.run --mode unattended

sudo tee /etc/systemd/system/xampp.service <<'EOF'
[Unit]
Description=XAMPP
[Service]
ExecStart=/opt/lampp/lampp start
ExecStop=/opt/lampp/lampp stop
Type=forking
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl enable xampp.service

echo "CONCLUÍDO"

echo "ALTERANDO A HTDOCS PARA LEITURA E ESCRITA TOTAL"

#ALTERANDO A HTDOCS PARA LEITURA E ESCRITA TOTAL
chmod -R 777 /opt/lampp/htdocs

'
