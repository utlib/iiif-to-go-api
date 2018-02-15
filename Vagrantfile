# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration header: DO NOT CHANGE
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # VirtualBox settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end
end
