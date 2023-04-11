#!/bin/bash
sudo yum install -y httpd
sudo service httpd start
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
$ ls
latest.tar.gz  wordpress
cd wordpress
cp wp-config-sample.php wp-config.php
nano wp-config.php
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'SpiceGirlsParadise' );
/** MySQL database username */
define( 'DB_USER', 'SpiceGirlsParadise' );
/** MySQL database password */
define( 'DB_PASSWORD', 'password123' );
/** MySQL hostname */
define( 'DB_HOST', 'localhost' );