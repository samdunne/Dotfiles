#!/bin/sh

set -e

INSTALLATION_SOURCE=instantclient_11_2
ORACLE_CLIENT_VERSION=11.2.0.4.0
ORACLE_INSTACLIENT_BASE=/usr/local/Oracle/product/instantclient
ORACLE_INSTALL_HOME=$ORACLE_INSTACLIENT_BASE/$ORACLE_CLIENT_VERSION

echo "Extracting..."
unzip -qq instantclient-basic-macos.x64-$ORACLE_CLIENT_VERSION.zip
unzip -qq instantclient-sdk-macos.x64-$ORACLE_CLIENT_VERSION.zip
unzip -qq instantclient-sqlplus-macos.x64-$ORACLE_CLIENT_VERSION.zip

cd $INSTALLATION_SOURCE

echo "Preparing for installation..."
mkdir -p $ORACLE_INSTALL_HOME/bin
mkdir -p $ORACLE_INSTALL_HOME/lib
mkdir -p $ORACLE_INSTALL_HOME/jdbc/lib
mkdir -p $ORACLE_INSTALL_HOME/rdbms/jlib
mkdir -p $ORACLE_INSTALL_HOME/sqlplus/admin

echo "Installing..."
mv ojdbc* $ORACLE_INSTALL_HOME/jdbc/lib/
# mv sdk $ORACLE_INSTALL_HOME/jdbc/lib/
mv x*.jar $ORACLE_INSTALL_HOME/rdbms/jlib/
mv glogin.sql $ORACLE_INSTALL_HOME/sqlplus/admin/
mv ./*dylib* $ORACLE_INSTALL_HOME/lib/
# mv sdk $ORACLE_INSTALL_HOME/lib/
mv ./*README $ORACLE_INSTALL_HOME/
mv ./* $ORACLE_INSTALL_HOME/bin/

cd /usr/local/bin
ln -s ../Oracle/product/instantclient/$ORACLE_CLIENT_VERSION/bin/sqlplus sqlplus

cd $ORACLE_INSTALL_HOME
mkdir -p share/instantclient
cd /usr/local/share
ln -s ../Oracle/product/instantclient/$ORACLE_CLIENT_VERSION/share/instantclient/ instantclient

echo "
export ORACLE_BASE=/usr/local/Oracle
export ORACLE_HOME=\$ORACLE_BASE/product/instantclient/$ORACLE_CLIENT_VERSION
export DYLD_LIBRARY_PATH=\$ORACLE_HOME/lib
export TNS_ADMIN=\$ORACLE_BASE/admin/network
" > /usr/local/share/instantclient/instantclient.sh

echo "source /usr/local/share/instantclient/instantclient.sh" >> ~/.extra

echo "Cleaning up..."
rm -rf $INSTALLATION_SOURCE

echo "Installation is now completed. Restart your shell to start using sqlplus"
