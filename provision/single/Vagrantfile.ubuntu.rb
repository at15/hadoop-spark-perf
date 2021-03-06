# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant single node script

Vagrant.configure(2) do |config|

  # use pre-built base box
  config.vm.box = "at15/hadoop-spark-perf"

  config.vm.box_check_update = false

  # mount apm and web folder
  config.vm.synced_folder "../../apm", "/home/vagrant/apm", \
    :create => true
  config.vm.synced_folder "../../web", "/home/vagrant/web", \
    :create => true

  # use private network
  config.vm.network :private_network, ip: "192.168.233.17"

  config.vm.provider "virtualbox" do |vb|
     # Don't show the GUI unless you have some bug
     vb.gui = false
     # 1GB will fail when run micro Hadoop bench
     vb.memory = "4096"
  end

end
