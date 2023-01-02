# Prometheus

## Prometheus Installation Systemd


Create the prometheus user:

```
sudo useradd --no-create-home --shell /bin/false prometheus
```

Create the necessary folders:

```
sudo mkdir /etc/prometheus \
/var/lib/prometheus 

```

Update the permissions:

```
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
```

Download the Prometheus binary:

```
export VERSION=2.41.0
curl -LsSo /tmp/prometheus-$VERSION.linux-amd64.tar.gz https://github.com/prometheus/prometheus/releases/download/v$VERSION/prometheus-$VERSION.linux-amd64.tar.gz
tar xfz /tmp/prometheus-$VERSION.linux-amd64.tar.gz
```

Copy the binaries to the system path:

```
sudo cp /tmp/prometheus-$VERSION.linux-amd64/prometheus /usr/local/bin/
sudo cp /tmp/prometheus-$VERSION.linux-amd64/promtool /usr/local/bin/
```

Copy the remaining folders and files:

```
sudo cp -r /tmp/prometheus-$VERSION.linux-amd64/consoles /etc/prometheus
sudo cp -r /tmp/prometheus-$VERSION.linux-amd64/console_libraries /etc/prometheus
sudo cp /tmp/prometheus-$VERSION.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yaml
```

Update the permissions:

```
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
```

Create the Systemd unit service file:

```
sudo vim /etc/systemd/system/prometheus.service
```

Content of `prometheus.service`:

```
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
```

Reload the units from Systemd:

```
sudo systemctl daemon-reload
```

Restart and enable the prometheus:

```
sudo systemctl enable --now prometheus
```
