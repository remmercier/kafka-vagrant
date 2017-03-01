# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #########################################
  #
  #              CONFIGURATION
  #
  #########################################

  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
  end
  
  config.vbguest.auto_update = false
  
  #config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"] 
  # Required for NFS to work, pick any local IP
  config.vm.network :private_network, ip: '192.168.50.50'
  # Use NFS for shared folders for better performance
  config.vm.synced_folder '.', '/vagrant', nfs: true

  #kafka
  config.vm.network :forwarded_port, guest: 9092, host: 9092
  #kafka-manager
  config.vm.network :forwarded_port, guest: 9000, host: 9000

  
  #########################################
  #
  #              PROVISIONNING
  #
  #########################################

  config.vm.provision "file", source: "kafka-manager-1.3.3.1.zip", destination: "/tmp/kafka-manager-1.3.3.1.zip" 
  config.vm.provision "file", source: "kafkamanager.service", destination: "/tmp/kafkamanager.service" 
  config.vm.provision "file", source: "kafka.service", destination: "/tmp/kafka.service" 
  config.vm.provision "file", source: "zk.service", destination: "/tmp/zk.service" 
  config.vm.provision :shell, :path => "setup.sh"

end
