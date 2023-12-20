#!/bin/bash

# Переключение на root-пользователя
sudo -s

# Установка пакета nfs-utils с использованием yum
yum install -y nfs-utils

# Включение и запуск firewalld
systemctl enable firewalld --now

# Добавление сервисов nfs3, rpc-bind и mountd в firewalld
firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
firewall-cmd --reload

# Включение и запуск nfs
systemctl enable nfs --now

# Создание директории /srv/share/upload
mkdir -p /srv/share/upload

# Настройка прав доступа для директории /srv/share
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

# Настройка экспорта NFS в файле /etc/exports
cat << EOF > /etc/exports
/srv/share *(rw,sync,root_squash)
EOF

# Обновление конфигурации экспорта
exportfs -r
