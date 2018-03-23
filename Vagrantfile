# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration header: DO NOT CHANGE
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 81, host: 8111
  config.vm.network "forwarded_port", guest: 80, host: 8222

  # VirtualBox settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end
  
  # Set up 
  config.vm.provision "shell", path: "setup/boot.sh"
  
  # Install Mongo and add seed
  config.vm.provision "file", source: "mongo-seed", destination: "/tmp/mongo-seed"
  config.vm.provision "shell", path: "setup/mongo.sh"
  
  # Install Apache as springboard for Loris
  config.vm.provision "shell", path: "setup/apache.sh"
  
  # Install Loris
  config.vm.provision "shell", path: "setup/loris.sh"
  
  # Install IIIF API
  if Dir.exist?("iiifAPI")
	config.vm.provision "shell", inline: 'echo "Provisioning IIIF API from local source..."'
	config.vm.provision "file", source: "iiifAPI", destination: "/home/vagrant/iiifAPI"
	config.vm.provision "shell", inline: 'mv /home/vagrant/iiifAPI /var/www/iiifAPI'
  end
  config.vm.provision "shell", path: "setup/iiifapi.sh"
  
  # Install Mirador
  if Dir.exist?("mirador")
	config.vm.provision "shell", inline: 'echo "Provisioning Mirador from local source..."'
	config.vm.provision "file", source: "mirador", destination: "/home/vagrant/mirador"
	config.vm.provision "shell", inline: 'mv /home/vagrant/mirador /var/www/mirador'
  end
  config.vm.provision "shell", path: "setup/mirador.sh"
  config.vm.provision "file", source: "html-seed/index.html", destination: "/home/vagrant/index.html"
  config.vm.provision "shell", inline: 'mv /home/vagrant/index.html /var/www/html/index.html'
  
  # Add splash
  config.vm.provision "file", source: "splash", destination: "/home/vagrant/splash"
  config.vm.provision "shell", inline: 'mv /home/vagrant/splash /var/www/html/splash'
  
  # Start IIIF API (Run on start)
  config.vm.provision "shell", run: 'always', inline: <<-SHELL
	service mongod start
  SHELL
  
  # Provision shared paths
  config.vm.synced_folder "loris", "/usr/local/share/images/synced", create: true
  
  # Done message
  config.vm.post_up_message = "IIIF API to Go is ready! Visit localhost:8000 on your browser to get started with IIIF API, or localhost:8222 to view your API's data via Mirador."
end
