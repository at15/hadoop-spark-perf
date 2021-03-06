# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant cluster mode

# /etc/hosts in base box
# 192.168.233.18 master.perf.at15
# 192.168.233.19 slave1.perf.at15
# 192.168.233.20 slave2.perf.at15
# 192.168.233.21 slave3.perf.at15

Vagrant.configure("2") do |config|
  config.vm.define :master do |alpha|
    alpha.vm.box = "at15/hadoop-spark-perf"
    alpha.vm.network :private_network, ip: "192.168.233.18"
    alpha.vm.hostname = "master"
    # TODO: mount web folder to nginx root
    alpha.vm.provider "virtualbox" do |vb|
       vb.gui = false
       vb.memory = "4096"
    end
    alpha.vm.provision "shell", inline: <<-SHELL
      /vagrant/config.sh
    SHELL
  end

  config.vm.define :slave1 do |beta|
    beta.vm.box = "at15/hadoop-spark-perf"
    beta.vm.network :private_network, ip: "192.168.233.19"
    beta.vm.hostname = "slave1"
    beta.vm.provider "virtualbox" do |vb|
       vb.gui = false
       vb.memory = "4096"
    end
    beta.vm.provision "shell", inline: <<-SHELL
      /vagrant/config.sh
    SHELL
  end

  config.vm.define :slave2 do |beta|
    beta.vm.box = "at15/hadoop-spark-perf"
    beta.vm.network :private_network, ip: "192.168.233.20"
    beta.vm.hostname = "slave2"
    beta.vm.provider "virtualbox" do |vb|
       vb.gui = false
       vb.memory = "4096"
    end
    beta.vm.provision "shell", inline: <<-SHELL
      /vagrant/config.sh
    SHELL
  end

end
