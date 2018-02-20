#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF API in a Box: Installing Mirador..."

# Download Mirador if not already provisioned
cd /var/www
if [ ! -d mirador ]; then
	echo "Provisioning from GitHub Mirador 2.6.0..."
	wget -q --no-check-certificate https://github.com/ProjectMirador/mirador/releases/download/v2.6.0/build.zip
	unzip -qq build.zip 'mirador/*' -d mirador
	rm -Rf build.zip
fi

# Move Mirador
mv mirador html/mirador
