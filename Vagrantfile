# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "VM1-Testing" do |vmHost1|

    vmHost1.vm.box = "ubuntu-jammy64-local"
    vmHost1.vm.hostname = "VM1-Testing"
    vmHost1.vm.network "private_network", :name => "", ip: "192.168.56.10"

    vmHost1.vm.disk :disk, size: "5GB", name: "#{vmHost1.vm.hostname}_extra_storage_5GB"
    vmHost1.vm.disk :disk, size: "3GB", name: "#{vmHost1.vm.hostname}_extra_storage_3GB"
    vmHost1.vm.disk :disk, size: "2GB", name: "#{vmHost1.vm.hostname}_extra_storage_2GB"
    vmHost1.vm.disk :disk, size: "1GB", name: "#{vmHost1.vm.hostname}_extra_storage_1GB_NO_USAR"

    vmHost1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "VM1-Testing"
      vb.cpus = 1
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    end

  end


  config.vm.define "VM2-Produccion" do |vmHost2|

    vmHost2.vm.box = "fedora-local"
    vmHost2.vm.hostname = "VM2-Produccion"
    vmHost2.vm.network "private_network", :name => "", ip: "192.168.56.11"

    vmHost2.vm.disk :disk, size: "5GB", name: "#{vmHost2.vm.hostname}_extra_storage_5GB"
    vmHost2.vm.disk :disk, size: "3GB", name: "#{vmHost2.vm.hostname}_extra_storage_3GB"
    vmHost2.vm.disk :disk, size: "2GB", name: "#{vmHost2.vm.hostname}_extra_storage_2GB"
    vmHost2.vm.disk :disk, size: "1GB", name: "#{vmHost2.vm.hostname}_extra_storage_1GB_NO_USAR"

    vmHost2.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "VM2-Produccion"
      vb.cpus = 1
      vb.linked_clone = true
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    end

  end

end