#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Installing Loris..."

# Kakadu
cd /usr/local/lib
wget -q --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/lib/Linux/x86_64/libkdu_v74R.so
chmod 755 libkdu_v74R.so
cd /usr/local/bin
wget -q --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/bin/Linux/x86_64/kdu_expand
chmod 755 kdu_expand

# Python and image library dependencies
apt-get install -qqy libjpeg8 libjpeg8-dev libfreetype6 libfreetype6-dev zlib1g-dev liblcms2-2 liblcms2-dev liblcms2-utils libtiff5-dev > /dev/null
ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/liblcms.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libtiff.so /usr/lib/
echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig
apt-get install -qqy python-dev python-setuptools python-pip > /dev/null
pip install -qq --upgrade pip
pip uninstall -qq PIL
pip uninstall -qq Pillow
apt-get purge -qq python-imaging > /dev/null
pip install -qq Werkzeug
pip install -qq configobj
pip install -qq Pillow

# WSGI
apt-get install -qqy libapache2-mod-wsgi > /dev/null

# Loris packages
cd /opt
wget -q --no-check-certificate https://github.com/loris-imageserver/loris/archive/2.0.1.zip
unzip -qq 2.0.1.zip
mv loris-2.0.1/ loris/
rm 2.0.1.zip

# Loris user
useradd -d /var/www/loris2 -s /sbin/false loris

# Image directory
cd /opt/loris

# Install
./setup.py install > /dev/null
cp etc/loris2.conf /etc/loris2.conf

# Loris-Apache integration
cd /etc/apache2
echo 'Listen *:81' >> ports.conf
echo '<VirtualHost *:81>
	ExpiresActive On
	ExpiresDefault "access plus 5184000 seconds"
	AllowEncodedSlashes On
	WSGIDaemonProcess loris2 user=loris group=loris processes=10 threads=15 maximum-requests=10000
	WSGIScriptAlias /loris /var/www/loris2/loris2.wsgi
	WSGIProcessGroup loris2
	SetEnvIf Request_URI ^/loris loris
	CustomLog ${APACHE_LOG_DIR}/loris-access.log combined env=loris
</VirtualHost>

<Directory /var/www/loris2>
		Order deny,allow
		Allow from all
		Require all granted
</Directory>' > sites-available/loris.conf
a2enmod expires > /dev/null
a2ensite loris > /dev/null
service apache2 restart > /dev/null
