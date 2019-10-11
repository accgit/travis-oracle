#!/bin/bash

BASE_DIR=$(dirname $0)
cd $BASE_DIR

sudo apt-get update -qq
sudo apt-get -y install -qq build-essential libaio1 unzip wget

sudo mkdir -p /opt/oracle

sudo unzip -o ./instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle
sudo unzip -o ./instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle

sudo ln -sf /opt/oracle/instantclient_12_1 /opt/oracle/instantclient
sudo ln -sf /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so
sudo ln -sf /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so

sudo bash -c 'echo /opt/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient'
if [ $? -ne 0 ]; then exit 1; fi

OCI8_VERSION='2.1.0'
OCI8_DIRNAME="oci8-$OCI8_VERSION"
OCI8_FILENAME="$OCI8_DIRNAME.tgz"

if [ ! -f "./$OCI8_NAME.tgz" ]; then
    wget -c -t 3 -O ./$OCI8_FILENAME https://pecl.php.net/get/$OCI8_FILENAME
fi

rm -rf ./$OCI8_DIRNAME
tar xvf ./$OCI8_FILENAME
cd $OCI8_DIRNAME
phpize
./configure -with-oci8=shared,instantclient,/opt/oracle/instantclient
make -j"$(nproc)"
sudo make install

cd ..
rm -rf package.xml ./$OCI8_DIRNAME

exit $?
