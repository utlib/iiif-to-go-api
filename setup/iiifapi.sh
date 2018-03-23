#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF API in a Box: Installing IIIF API..."

# Download IIIF API if not already provisioned
cd /var/www
if [ ! -d iiifAPI ]; then
	echo "Provisioning from repository..."
	git clone -q https://github.com/utlib/utl_iiif_api.git iiifAPI
fi

# Set up API
cd iiifAPI
pip install -qq -r requirements.txt

# Create user
useradd -d /var/www/iiifAPI -s /sbin/false iiifapi

# API-Apache integration
cd /etc/apache2
echo 'Listen *:8000' >> ports.conf
echo '
<VirtualHost *:8000>
	AllowEncodedSlashes On
	WSGIDaemonProcess iiifapi python-path=/var/www/iiifAPI user=iiifapi group=iiifapi processes=10 threads=15 maximum-requests=10000
	WSGIScriptAlias / /var/www/iiifAPI/iiifAPI/wsgi.py
	<Location />
		Header set Access-Control-Allow-Origin "*"
		WSGIProcessGroup iiifapi
		Require all granted
	</Location>
	
	Alias /static /var/www/iiifAPI/static
	<Directory /var/www/iiifAPI/static>
		Options FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>
</VirtualHost>
' > sites-available/iiifapi.conf
a2enmod headers > /dev/null
a2ensite iiifapi > /dev/null
service apache2 restart > /dev/null
