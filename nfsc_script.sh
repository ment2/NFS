#!/bin/bash

# Установка пакета nfs-utils с использованием yum
yum install -y nfs-utils

# Добавление записи в /etc/fstab для монтирования NFS
echo "192.168.57.1:/srv/share/ /mnt nfs vers=3,proto=tcp,auto,x-systemd.automount 0 0" >> /etc/fstab

# Перезагрузка системдемона
systemctl daemon-reload

# Перезапуск сервиса remote-fs.target
systemctl restart remote-fs.target
