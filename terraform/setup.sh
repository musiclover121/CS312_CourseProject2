#!/bin/bash

set -e

sudo apt update -y
sudo apt install -y openjdk-21-jre-headless wget screen

sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft || true

sudo mkdir -p /opt/minecraft/server

cd /opt/minecraft/server

sudo wget https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar -O server.jar

echo "eula=true" | sudo tee eula.txt

sudo chown -R minecraft:minecraft /opt/minecraft

sudo tee /etc/systemd/system/minecraft.service > /dev/null <<EOF
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=minecraft
WorkingDirectory=/opt/minecraft/server

ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui
ExecStop=/bin/kill -SIGINT \$MAINPID

Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft
