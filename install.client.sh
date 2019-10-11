#!/bin/sh -e

mkdir /opt/oracle

cd /opt/oracle
unzip ./oracle/instantclient-basic-linux.x64-12.1.0.2.0.zip
unzip ./oracle/instantclient-sdk-linux.x64-12.1.0.2.0.zip

ln -s /opt/oracle/instantclient_12_1/libclntsh.so.12.1 /opt/oracle/instantclient_12_1/libclntsh.so
ln -s /opt/oracle/instantclient_12_1/libocci.so.12.1 /opt/oracle/instantclient_12_1/libocci.so

echo /opt/oracle/instantclient_12_1 > /etc/ld.so.conf.d/oracle-instantclient

pecl install oci8

echo instantclient,/opt/oracle/instantclient_12_1
echo "extension = oci8.so" >> /etc/php/7.1/fpm/php.ini
echo "extension = oci8.so" >> /etc/php/7.1/cli/php.ini

service php7.1-fpm restart
