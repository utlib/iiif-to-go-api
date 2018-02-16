# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration header: DO NOT CHANGE
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 81, host: 8111

  # VirtualBox settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end
  
  # Set up 
  config.vm.provision "shell", path: "setup/boot.sh"
  
  # Install Mongo and add seed
  config.vm.provision "shell", path: "setup/mongo.sh"
  
  # Install Apache as springboard for Loris
  config.vm.provision "shell", path: "setup/apache.sh"
  
  # Install Loris
  config.vm.provision "shell", path: "setup/loris.sh"
  
  # Install Pipenv
  config.vm.provision "shell", path: "setup/pipenv.sh"
  
  # Install IIIF API
  if Dir.exist?("iiifAPI")
	config.vm.provision "shell", inline: 'echo "Provisioning IIIF API from local source..."'
	config.vm.provision "file", source: "iiifAPI", destination: "/home/vagrant/iiifAPI"
  end
  config.vm.provision "shell", privileged: false, path: "setup/iiifapi.sh"
  
  # Start IIIF API (Run on start)
  config.vm.provision "shell", run: 'always', inline: <<-SHELL
	service mongod start
  SHELL
  
  # Provision shared paths
  config.vm.synced_folder "loris", "/usr/local/share/images/synced"
  
  # Done message
  config.vm.post_up_message = "IIIF API to Go is ready! Visit localhost:8000 on your browser to get started."
end
