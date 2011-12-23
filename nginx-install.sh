#!/bin/sh
# chmod +x nginx-install.sh && /root/nginx-install.sh

    cp /root/setup/sources.list /etc/apt/sources.list

    wget http://www.dotdeb.org/dotdeb.gpg
    cat dotdeb.gpg | apt-key add -

    gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
    gpg -a --export CD2EFD2A | apt-key add -

    apt-get -y remove bind9
    apt-get -y remove apache*
    apt-get -y autoremove
    apt-get clean
    apt-get -y update
    apt-get -y upgrade
    apt-get -y remove samba*
    apt-get -y install nano wget unrar zip curl build-essential python-software-properties finger kbd openssl sysstat apache2-utils htop chkconfig
    apt-get -y install libpcre3 libpcre3-dev libssl-dev zlib1g-dev iftop
    apt-get clean

    apt-get -y install nginx
    apt-get -y install php5-fpm php5-mysql php5-curl php5-gd php5-mcrypt php5-mhash php5-xcache
    apt-get -y install mysql-client

    mkdir -p /home/nginx/site/{public,private,log,backup}
    chown -R www-data:www-data /home/nginx

    cp /root/setup/www.conf /etc/php5/fpm/pool.d/www.conf
    cp /root/setup/php.ini /etc/php5/fpm/php.ini
    cp /root/setup/xcache.ini /etc/php5/conf.d/xcache.ini
    cp /root/setup/nginx.conf /etc/nginx/nginx.conf
    cp /root/setup/fastcgi.conf /etc/nginx/fastcgi.conf
    cp /root/setup/virtual.conf /etc/nginx/conf.d/virtual.conf
    cp /root/setup/phpinfo.php /home/nginx/site/public/phpinfo.php

    chkconfig saslauthd off
    echo "www-data soft nofile 65536" >>/etc/security/limits.conf
    echo "www-data hard nofile 65536" >>/etc/security/limits.conf
    ulimit -n 65536

    service php5-fpm restart
    service nginx restart