#!/bin/bash
echo " "
jeshile='\e[40;38;5;82m'
jo='\e[0m'
os=$(exec uname -m|grep 64)
if [ "$os" = "" ]
then os="x86"
else os="x64"
fi

DIRE=$(hostname -I)
DIREMODE=$(expr "$DIRE" : '\(.*\).')

echo -e "${jeshile} +-----------------------------+ \e[0m"
echo -e "${jeshile} ¦Revisando Version del sistema¦ \e[0m"
echo -e "${jeshile} +-----------------------------+ \e[0m"
sleep "5"

echo -e "${jeshile} +------------------------------+ \e[0m"
echo -e "${jeshile} ¦Sistema de $os Bits Detecatado¦ \e[0m"
echo -e "${jeshile} +------------------------------+ \e[0m"
sleep "5"

echo -e "${jeshile} +--------------------------------+ \e[0m"
echo -e "${jeshile} ¦   Prerequisitos para instalar  ¦ \e[0m"
echo -e "${jeshile} ¦      Flusonic 20.12            ¦ \e[0m"
echo -e "${jeshile} ¦                                ¦ \e[0m"
echo -e "${jeshile} ¦  1 Usuario para Flusonic       ¦ \e[0m"
echo -e "${jeshile} ¦  2 Contraseña para Flusonic    ¦ \e[0m"
echo -e "${jeshile} ¦  3 Puerto de acceso Flusonic   ¦ \e[0m"
echo -e "${jeshile} ¦  4 Servidor Nginx              ¦ \e[0m"
echo -e "${jeshile} +--------------------------------+ \e[0m"
echo ""
echo ""
sleep "5"


echo -e "${jeshile} +---------------------------+ \e[0m"
echo -e "${jeshile} ¦    Escribe un usuario     ¦ \e[0m"
echo -e "${jeshile} ¦      para Flusonic        ¦ \e[0m"
echo -e "${jeshile} ¦                           ¦ \e[0m"
echo -e "${jeshile} ¦    ejemplo: admin         ¦ \e[0m"
echo -e "${jeshile} +---------------------------+ \e[0m"
sleep "3"

read USERFLUSO
echo "Tu Usuario de administrador para Flusonic es: $USERFLUSO"
echo ""

echo -e "${jeshile} +---------------------------+ \e[0m"
echo -e "${jeshile} ¦  Escribe la contraseña    ¦ \e[0m"
echo -e "${jeshile} ¦      para Flusonic        ¦ \e[0m"
echo -e "${jeshile} ¦                           ¦ \e[0m"
echo -e "${jeshile} ¦ Usa una contraseña segura ¦ \e[0m"
echo -e "${jeshile} ¦                           ¦ \e[0m"
echo -e "${jeshile} ¦ ejemplo Abc12@9#hX        ¦ \e[0m"
echo -e "${jeshile} ¦                           ¦ \e[0m"
echo -e "${jeshile} +---------------------------+ \e[0m"
sleep "3"

read CONTRAFLUSO
echo "Tu Contraseña de Flusonic es: $CONTRAFLUSO"
echo ""

echo -e "${jeshile} +---------------------------+ \e[0m"
echo -e "${jeshile} ¦    Escribe un numero      ¦ \e[0m"
echo -e "${jeshile} ¦      de puerto para       ¦ \e[0m"
echo -e "${jeshile} ¦        Flusonic           ¦ \e[0m"
echo -e "${jeshile} ¦                           ¦ \e[0m"
echo -e "${jeshile} ¦    ejemplo: 8080          ¦ \e[0m"
echo -e "${jeshile} +---------------------------+ \e[0m"
sleep "3"

read PUERTOFLUSO
echo "Tu Usuario de administrador para Flusonic es: $PUERTOFLUSO"
echo ""




echo -e "${jeshile} +---------------------------+ \e[0m"
echo -e "${jeshile} ¦  Actulizando el sisteama  ¦ \e[0m"
echo -e "${jeshile} +---------------------------+ \e[0m"
sleep "3"

sudo apt update -y


echo -e "${jeshile} +----------------------+ \e[0m"
echo -e "${jeshile} ¦  Instalando Nginx    ¦ \e[0m"
echo -e "${jeshile} +----------------------+ \e[0m"
sleep "3"

sudo apt install nginx -y
    echo 'server {
        listen 127.0.0.1:135;
        root /usr/share/nginx/html;
        index index.html index.htm;
        server_name localhost;
        location / {
                try_files $uri $uri/ =404;
        }
}' > /etc/nginx/sites-available/flussonic
    ln -s /etc/nginx/sites-available/flussonic /etc/nginx/sites-enabled/
    
echo -e "${jeshile} +--------------------------+ \e[0m"
echo -e "${jeshile} ¦  Reiniciando Nginx       ¦ \e[0m"
echo -e "${jeshile} +--------------------------+ \e[0m"
sleep "3"    

sudo  service nginx restart



echo -e "${jeshile} +-------------------------------+ \e[0m"
echo -e "${jeshile} ¦     Desinstalando Flusonic    ¦ \e[0m"
echo -e "${jeshile} +-------------------------------+ \e[0m"
sleep "3"

sudo apt -y purge flussonic
sudo rm -rf /etc/flussonic
sudo rm -rf /opt/flussonic
sudo apt-get -y autoremove
sudo systemctl is-active --quiet flussonic && systemctl stop flussonic 
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo rm -f /etc/apt/sources.list.d/flussonic.list
sudo rm -f /etc/apt/sources.list.d/erlyvideo.list


echo -e "${jeshile} +------------------------+ \e[0m"
echo -e "${jeshile} ¦    Deshabilitando      ¦ \e[0m"
echo -e "${jeshile} ¦    Actualizaciones     ¦ \e[0m"
echo -e "${jeshile} ¦    Automaticas         ¦ \e[0m"
echo -e "${jeshile} +------------------------+ \e[0m"
sleep "3"

sudo echo "127.0.0.1    retroview.flussonic111.com">> /etc/hosts
sudo echo "127.0.0.1    apt.flussonic.com">> /etc/hosts
sudo echo "127.0.0.1    license4.erlyvideo.org">> /etc/hosts
sudo echo "127.0.0.1    flussonic.infomyr.com">> /etc/hosts



echo -e "${jeshile} +---------------------------+ \e[0m"
echo -e "${jeshile} ¦    Instalando Flusonic    ¦ \e[0m"
echo -e "${jeshile} +---------------------------+ \e[0m"
sleep "3"

sudo dpkg -i tools/*.deb


echo -e "${jeshile} +-----------------------------+ \e[0m"
echo -e "${jeshile} ¦    Configurando acceso      ¦ \e[0m"
echo -e "${jeshile} ¦    para el panel Flusonic   ¦ \e[0m"
echo -e "${jeshile} +-----------------------------+ \e[0m"
sleep "3"

sudo echo "# Global settings:" >> /etc/flussonic/flussonic.conf
sudo echo "http $PUERTOFLUSO;" >> /etc/flussonic/flussonic.conf
sudo echo "pulsedb /var/lib/flussonic;" >> /etc/flussonic/flussonic.conf
sudo echo "session_log /var/lib/flussonic;" >> /etc/flussonic/flussonic.conf
sudo echo "edit_auth $USERFLUSO $CONTRAFLUSO;" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# DVRs:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Remote sources:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Ingest streams:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Dynamic rewrites:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Publish locations:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Disk file caches:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# VOD locations:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# DVB cards:" >> /etc/flussonic/flussonic.conf
sudo echo " " >> /etc/flussonic/flussonic.conf
sudo echo "# Plugins:" >> /etc/flussonic/flussonic.conf
sudo echo "plugin iptv {" >> /etc/flussonic/flussonic.conf
sudo echo "  database sqlite:///opt/flussonic/priv/iptv.db;" >> /etc/flussonic/flussonic.conf
sudo echo "}" >> /etc/flussonic/flussonic.conf



sudo cp tools/license.txt /etc/flussonic/license.txt
#sudo cp tools/flussonic.conf /etc/flussonic/flussonic.conf
sudo cp tools/priv/* /opt/flussonic/priv/


echo -e "${jeshile} +-----------------------------+ \e[0m"
echo -e "${jeshile} ¦  Reiniciando Flusonic       ¦ \e[0m"
echo -e "${jeshile} +-----------------------------+ \e[0m"
sleep "3"

sudo /etc/init.d/flussonic restart


echo " "
echo -e "${jeshile} +----------------------------------------------------------+ \e[0m"
echo -e "${jeshile} ¦      Creditos y soporte melcocha14@gmail.com             ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦      Link de acceso al Panel de clientes                 ¦ \e[0m"
echo -e "${jeshile} ¦      http://$DIREMODE:$PUERTOFLUSO/admin/#/              ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦     Tus Datos del acceso al Panel son:                   ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦      Usiario:   $USERFLUSO                               ¦ \e[0m"
echo -e "${jeshile} ¦      Password:  $CONTRAFLUSO                             ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} ¦     Guarda tus Datos en un lugar seguro                  ¦ \e[0m"
echo -e "${jeshile} ¦                                                          ¦ \e[0m"
echo -e "${jeshile} +----------------------------------------------------------+ \e[0m"


