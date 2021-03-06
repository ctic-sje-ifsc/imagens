#!/bin/sh

set -e

sh -c '/bin/sed -i "s/^Listen 80.*/Listen 8083/g" /etc/apache2/ports.conf'
sh -c '/bin/sed -i "s/Listen 443$/Listen 44383/g" /etc/apache2/ports.conf'
sh -c '/bin/sed -i "1s/.*/<VirtualHost *>/g" /etc/apache2/sites-enabled/001-fog.conf'
sh -c '/bin/sed -i "6s/.*/ServerName 191.36.8.25/g" /etc/apache2/sites-enabled/001-fog.conf'
sh -c '/bin/sed -i "6s/.*/CN = 191.36.8.25/g" /opt/fog/snapins/ssl/req.cnf'
sh -c '/bin/sed -i "10s/.*/DNS.1 = 191.36.8.25/g" /opt/fog/snapins/ssl/req.cnf'
sh -c '/bin/sed -i "4s/.*/DNS.1 = 191.36.8.25/g" /opt/fog/snapins/ssl/ca.cnf'
sh -c '/bin/sed -i "/chain/ s@//.*/fog@//191.36.8.25:8083/fog@g" /tftpboot/default.ipxe'
sh -c '/bin/sed -i "s/ServerName.*/ServerName 191.36.8.25/g" /etc/apache2/sites-available/001-fog.conf'
sh -c "/bin/sed -i '/HOST/ s/\".*\"/\"191.36.8.25\"/g' /var/www/fog/lib/fog/config.class.php"
sh -c '/etc/init.d/start.services'

exec "$@"
