#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF API in a Box: Installing Mirador..."

# Download Mirador if not already provisioned
cd /var/www
if [ ! -d mirador ]; then
	echo "Provisioning from GitHub Mirador 2.6.0..."
	wget -q --no-check-certificate https://github.com/utlib/mirador/releases/download/2.6-lazy-collection-tree/build.zip
	unzip -qq build.zip 'mirador/*' > /dev/null 2>&1
	rm -Rf build.zip
fi

# Move Mirador
mv mirador html/mirador
