#!/bin/bash

# Create the node exporter user:

useradd --no-create-home --shell /bin/false node_exporter


# Download the Node Exporter binary:

export VERSION=1.5.0
curl -LsSo /tmp/node_exporter-$VERSION.linux-amd64.tar.gz https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz
tar xfz /tmp/node_exporter-$VERSION.linux-amd64.tar.gz -C /tmp/

# Copy the binary to the system path:

cp /tmp/node_exporter-$VERSION.linux-amd64/node_exporter /usr/local/bin/

# Update the permissions:

chown node_exporter:node_exporter /usr/local/bin/node_exporter

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
ExecStart=/usr/local/bin/node_exporter 

[Install]
WantedBy=multi-user.target
EOF

# Reload the units from Systemd:

systemctl daemon-reload

# Restart and enable the node exporter:

systemctl enable --now node_exporter

