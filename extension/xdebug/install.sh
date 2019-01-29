#!/bin/bash

# 当前位置

basepath=$(cd `dirname $0`; pwd)

echo "----------------- show the install file ----------------------------"
echo $basepath

extensionFile=$basepath"/xdebug.tar.gz"
echo $extensionFile

cd $basepath
# if file not exists and get source
if [ ! -f $extensionFile ]; then
  echo "----------------- get source file ----------------------------"
  curl -L https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_5.tar.gz -o xdebug.tar.gz
fi

# install ext
echo "----------------- configure, make and make install  ----------------------------"
tar -zxvf xdebug.tar.gz
cd xdebug-XDEBUG_2_5_5
phpize
./configure
make
make install
docker-php-ext-enable xdebug 

# option
echo "----------------- setting xdubug ----------------------------"
export TMP_XDEBUG_INI_FILE=$(php --ini | grep xdebug.ini)
echo "----------------- the path of xdebug.ini file is ${TMP_XDEBUG_INI_FILE} ----------------------------"
echo "[XDebug]" >> $TMP_XDEBUG_INI_FILE
echo "xdebug.enable=1" >> $TMP_XDEBUG_INI_FILE
echo "xdebug.remote_enable=1" >> $TMP_XDEBUG_INI_FILE
echo "xdebug.idekey=PHPSTORM" >> $TMP_XDEBUG_INI_FILE
echo "xdebug.remote_host="$XDEUBG_REMOTE_HOST >> $TMP_XDEBUG_INI_FILE
echo "xdebug.remote_port="$XDEUBG_REMOTE_PORT >> $TMP_XDEBUG_INI_FILE
echo "xdebug.remote_log=/var/log/php/xdebug_remote.log" >> $TMP_XDEBUG_INI_FILE