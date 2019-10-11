#!/bin/sh -e

wget https://raw.githubusercontent.com/accgit/travis-oracle/master/oracle/client/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp
wget https://raw.githubusercontent.com/accgit/travis-oracle/master/oracle/client/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp
wget https://raw.githubusercontent.com/accgit/travis-oracle/master/oracle/client/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm /tmp

sudo apt-get install alien
sudo alien /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
sudo alien /tmp/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
sudo alien /tmp/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

echo 'instantclient,/usr/lib/oracle/12.2/client64/lib' | pecl install oci8 && php-ext-enable oci8
service apache2 restart
