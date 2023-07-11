#!/bin/bash

# Create the prometheus user:

useradd --no-create-home --shell /bin/false prometheus

# Create the necessary folders:

mkdir /etc/prometheus \
/var/lib/prometheus 

# Move the certifiicate to right place

mv /home/vagrant/node_exporter.crt /etc/prometheus/

# Update the permissions:

chown -R prometheus:prometheus /etc/prometheus
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

# Create prometheus configuration file


cat >>/etc/prometheus/prometheus.yml<<EOF
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
    basic_auth:
      username: prometheus
      password: marcelo
    static_configs:
      - targets: ["172.16.16.101:9100", "172.16.16.102:9100"]
EOF

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

