# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
COURSE=#{ENV['COURSE']}
sudo chown -R www-data /opt/$COURSE/
cd /edx/app/edxapp/edx-platform
sudo -u www-data /edx/bin/python.edxapp ./manage.py cms --settings=aws import /edx/var/edxapp/data /opt/$COURSE
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "mitodlginkgo-devstack-virtualbox.box"
  config.vm.define "mitodl_ginkgo" do |mitodl_ginkgo|
  end
  # https://wiki.libvirt.org/page/Virtio
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--nictype1', 'virtio', "--audio", "none"]
  end
  # Port forwarding for openedx services
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, guest: 8000, host: 8000  # LMS
  config.vm.network :forwarded_port, guest: 18010, host: 18010  # Studio
  config.vm.network :forwarded_port, guest: 9200, host: 9200  # Elasticsearch
  config.vm.network :forwarded_port, guest: 18080, host: 18080  # Forums
  config.vm.network :forwarded_port, guest: 9876, host: 9876  # ORA2 Karma tests
  config.vm.synced_folder './', '/opt', mount_options: ['dmode=775,fmode=664']
  config.vm.provision "shell", inline: $script, args: ENV['course']
  config.vm.hostname = "mitodlginkgo"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "4096"
  end
end
