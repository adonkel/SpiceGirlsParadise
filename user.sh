#!/bin/bash
apt-get update -y
apt-get install apache2 -y
systemctl restart apache2

wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

# change these values
echo "define( 'DB_NAME', 'addb' );" >> /srv/www/wordpress/wp-config.php
echo "define( 'DB_USER', 'username' );" >> /srv/www/wordpress/wp-config.php
echo "define( 'DB_PASSWORD', 'password' );" >> /srv/www/wordpress/wp-config.php
echo "define( 'DB_HOST', 'adonk-0.ckkhag7mpnl6.us-east-1.rds.amazonaws.com' );" >> /srv/www/wordpress/wp-config.php

echo "define('AUTH_KEY',         'jcS\$N<p^k^v>WbBQ*6ZXKTC@=ZU^Ru+^kGG)0Yz)#CLak[FAHMeos2yRrTQWV.}y');" >> /srv/www/wordpress/wp-config.php
echo "define('SECURE_AUTH_KEY',  'Dt7E}x+DR4Xe=7Ncy(uRAB|-&2(SspjGA6t0Zc})Si5>h{M.7hJO}CQ[z<%\$FA3?');" >> /srv/www/wordpress/wp-config.php
echo "define('LOGGED_IN_KEY',    'q{Eix;3jNaqvlFNjk(FKZn2OofXcR\`:WH)7ll:~5c.!,KoYi0-hW!E{!+{&]Nzq2');" >> /srv/www/wordpress/wp-config.php
echo "define('NONCE_KEY',        '&Ee|T;+/+~zv(&16uZR3ui GrU0>~u@-a6K+1TbYSAfg3p!b\`YuRbxOB\`,h{VVZP');" >> /srv/www/wordpress/wp-config.php
echo "define('AUTH_SALT',        '\`18AaWLR;8jnvqcG8]=>J+-Rsm1Z+Y&d\$aCI4cWUu<Z4=%_CzI?U2O^!jL1FSQ:R');" >> /srv/www/wordpress/wp-config.php
echo "define('SECURE_AUTH_SALT', '8f-7rt=g0#]F)K8y+jaPT;dV=O:nG 9jGjn.P3R8jY4(y<|[i?&/MiL-EH\`%{m&N');" >> /srv/www/wordpress/wp-config.php
echo "define('LOGGED_IN_SALT',   '*{NgNvs.uiJsi;5zL(oA_~I3WLh28-jKjVW)y+^3?=]ON;;]s*|H.g7;0S[\$/RY.');" >> /srv/www/wordpress/wp-config.php
echo "define('NONCE_SALT',       'V^HBATZ!.0Qx5Mz+5D.(|1@#A1lAt-84W1)Lp}{lB+UcHE2e!dMZc=IaMFN{}:*G');" >> /srv/www/wordpress/wp-config.php

#!/bin/bash

# Install and start MariaDB
sudo apt update
sudo apt install mariadb-server -y
sudo systemctl start mariadb.service

# Install Ghostscript and Apache2 with PHP modules
sudo apt install ghostscript -y
sudo apt install libapache2-mod-php -y
sudo apt install php-bcmath -y
sudo apt install php-curl -y
sudo apt install php-imagick -y
sudo apt install php-intl -y
sudo apt install php-json -y
sudo apt install php-mbstring -y
sudo apt install php-mysql -y
sudo apt install php-xml -y
sudo apt install php-zip -y

# Install MySQL server and PHP
sudo apt install mysql-server -y
sudo apt install php -y

# Create Apache virtual host for WordPress
sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null <<EOF
<VirtualHost *:80>
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
</VirtualHost>
EOF

# Enable the virtual host and mod_rewrite
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo systemctl reload apache2

# Install WordPress in /srv/www/wordpress directory
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
sudo -u www-data curl https://wordpress.org/latest.tar.gz | tar zx -C /srv/www

# Check the status of Apache2
sudo systemctl status apache2
