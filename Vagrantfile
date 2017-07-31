# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.define "mitodl_ficus" do |mitodl_ficus|
  end
  # https://wiki.libvirt.org/page/Virtio
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--nictype1', 'virtio']
  end
  # Port forwarding for openedx services
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, guest: 8000, host: 8000  # LMS
  config.vm.network :forwarded_port, guest: 18010, host: 18010  # Studio
  config.vm.network :forwarded_port, guest: 9200, host: 9200  # Elasticsearch
  config.vm.network :forwarded_port, guest: 18080, host: 18080  # Forums
  config.vm.network :forwarded_port, guest: 9876, host: 9876  # ORA2 Karma tests
  # Mounted folders
  config.vm.hostname = "mitodlficus"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
  end
  # Install and configure salt
  config.vm.provision :salt do |salt|
    salt.minion_config = 'minion.conf'
    salt.bootstrap_options = '-U -Z -b git'
    salt.install_type = 'git'
    salt.masterless = true
    salt.colorize = true
    salt.verbose = true
    salt.run_highstate = true
  end
end
