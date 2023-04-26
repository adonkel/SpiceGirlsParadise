#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo service apache2 start -y
sudo apt install mariadb-server -y
sudo systemctl start mariadb.service -y
sudo apt install ghostscript
sudo apt install libapache2-mod-php
sudo apt install mysql-server-8.0 -y
sudo apt install php -y
sudo apt install php-bcmath -y
sudo apt install php-curl -y
sudo apt install php-imagick -y
sudo apt install php-intl -y
sudo apt install php-json -y
sudo apt install php-mbstring -y
sudo apt install php-mysql -y
sudo apt install php-xml -y
sudo apt install php-zip -y
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
curl -o /etc/apache2/sites-available/wordpress.conf https://github.com/adonkel/wordpress/blob/648b6600e22c7917bf6954398b748c515238457c/wordpress.conf
echo "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload


