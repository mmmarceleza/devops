#!/bin/bash

# Create the node exporter user:

useradd --no-create-home --shell /bin/false node_exporter


# Download the Node Exporter binary:

export VERSION=1.5.0
curl -LsSo /tmp/node_exporter-$VERSION.linux-amd64.tar.gz https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz
tar xfz /tmp/node_exporter-$VERSION.linux-amd64.tar.gz -C /tmp/

# Copy the binary to the system path:

cp /tmp/node_exporter-$VERSION.linux-amd64/node_exporter /usr/local/bin/


# Create Node Exporter folder

mkdir -p /etc/node_exporter

# Move the certifiicates to right place

mv /home/vagrant/node_exporter.* /etc/node_exporter/

# Create the Configuratio File

cat >>/etc/node_exporter/config.yml<<EOF
tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key
basic_auth_users:
  prometheus: \$2y\$12\$NkgieMfEjnOTUTqofFpBl.UjYFyzGCUqwjd7NoTaLufdXVVBoSv5S
EOF

# Update the permissions:

chown node_exporter:node_exporter /usr/local/bin/node_exporter
chown -R node_exporter:node_exporter /etc/node_exporter

# Create the node exporter unit to the correct path

cat >>/etc/systemd/system/node_exporter.service<<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.config.file=/etc/node_exporter/config.yml

[Install]
WantedBy=multi-user.target
EOF

# Reload the units from Systemd:

systemctl daemon-reload

# Restart and enable the node exporter:

systemctl enable --now node_exporter

