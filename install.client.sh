wget -nv https://raw.githubusercontent.com/accgit/docker/master/docker-oracle/oracle/oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb
wget -nv https://raw.githubusercontent.com/accgit/docker/master/docker-oracle/oracle/oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb
wget -nv https://raw.githubusercontent.com/accgit/docker/master/docker-oracle/oracle/oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb

dpkg -i oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb
dpkg -i oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb
dpkg -i oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb

ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib/
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib/

echo 'instantclient,/usr/lib/oracle/12.2/client64/lib' | pecl install oci8 && docker-php-ext-enable oci8
