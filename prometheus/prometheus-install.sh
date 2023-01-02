#!/bin/bash

# Create the prometheus user:

useradd --no-create-home --shell /bin/false prometheus

# Create the necessary folders:

mkdir /etc/prometheus \
/var/lib/prometheus 

# Update the permissions:

chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

# Download the Prometheus binary:

export VERSION=2.41.0
curl -LsSo /tmp/prometheus-$VERSION.linux-amd64.tar.gz https://github.com/prometheus/prometheus/releases/download/v$VERSION/prometheus-$VERSION.linux-amd64.tar.gz
tar xfz /tmp/prometheus-$VERSION.linux-amd64.tar.gz -C /tmp/

# Copy the binaries to the system path:

cp /tmp/prometheus-$VERSION.linux-amd64/prometheus /usr/local/bin/
cp /tmp/prometheus-$VERSION.linux-amd64/promtool /usr/local/bin/

# Copy the remaining folders and files:

cp -r /tmp/prometheus-$VERSION.linux-amd64/consoles /etc/prometheus
cp -r /tmp/prometheus-$VERSION.linux-amd64/console_libraries /etc/prometheus
cp /tmp/prometheus-$VERSION.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml

# Update the permissions:

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
chown prometheus:prometheus /etc/prometheus/prometheus.yml

# Create the prometheus unit to the correct path

cat >>/etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload the units from Systemd:

systemctl daemon-reload

# Restart and enable the prometheus:

systemctl enable --now prometheus

