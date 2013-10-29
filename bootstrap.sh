#!/usr/bin/env bash
# Base Vagrant config
# Author:  Dan Bough (daniel.bough <at> gmail <dot> com / www.danielbough.com)
# License:  GPLv3
# Copyright 2013
# 
# Packages installed:  mysql 5.5, php5 with mysql drivers, apache2, git

# Unlock the root and give it a password? (YES/NO)
ROOT=YES

# Git repo to download
# REPO=xx/xx

if [ ! -f /var/log/firsttime ];
then
	sudo touch /var/log/firsttime

    # Set credentials for MySQL
	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password password'
	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password password'

    # Install packages
    sudo apt-get update
    sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 git libapache2-mod-php5

    # Add timezones to database
    mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -ppassword mysql

    # Download git repo stuff
    # sudo git clone https://github.com/foo/bar -b $REPO

    # Allow URL rewrites
    sudo a2enmod rewrite
    sudo sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

    # php5-mysql comes w/mysql drivers, but we still have to update php.ini to use them.
    sudo sed -i 's/;pdo_odbc.db2_instance_name/;pdo_odbc.db2_instance_name\nextension=pdo_mysql.so/' /etc/php5/apache2/php.ini
	
    sudo service apache2 restart
fi

# Unlock root and set password	
if [ $ROOT = 'YES' ]
then
	sudo usermod -U root
	echo -e "password\npassword" | sudo passwd root
fi