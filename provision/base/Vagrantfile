# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant base box script

Vagrant.configure(2) do |config|

  # the base box is ubuntu 16.04 LTS
  config.vm.box = "bento/ubuntu-16.04"

  # check update, change it to false you are trying out different provision scripts
  config.vm.box_check_update = true

  config.vm.provider "virtualbox" do |vb|
     # Don't show the GUI unless you have some bug
     vb.gui = false
     # Customize the amount of memory on the VM,
     # 2GB is enough for compiling things on the base box, for real vm, you need bigger
     vb.memory = "2048"
  end

end
