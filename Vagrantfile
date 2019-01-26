# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

VAGRANTFILE_VERSION = "2"

USER = "vagrant"
NUM_MASTERS = ENV['NUM_MASTERS'] || 1
NUM_NODES = ENV['NUM_NODES'] || 1

VERSIONS = YAML.load_file("#{Dir.pwd}/versions.yml")

Vagrant.configure(VAGRANTFILE_VERSION) do |config|

  config.landrush.enabled = true

  # Masters
  (1..NUM_MASTERS.to_i).each do |i|
    config.vm.define "master-#{i}" do |master|
      master.vm.box = "centos/7"
      master.vm.hostname = "master-#{i}"
      master.vm.provider "virtualbox" do |v|
        v.name = "master-#{i}"
        v.memory = 2048
        v.cpus = 2
      end

      master.vm.synced_folder "synced-folder", "/home/#{USER}/synced-folder",
        group: USER,
        owner: USER,
        mount_options: ["dmode=775,fmode=664"]

      for file in Dir.glob("scripts/tools/*").sort do
        master.vm.provision "shell", path: file, env: VERSIONS.merge({ :USER => USER})
      end

      master.vm.provision "shell", path: "scripts/setup/master.sh"
    end
  end

  # Nodes
  (1..NUM_NODES.to_i).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "node-#{i}"
      node.vm.provider "virtualbox" do |v|
        v.name = "node-#{i}"
        v.memory = 2048
        v.cpus = 1
      end

      node.vm.synced_folder "synced-folder", "/home/#{USER}/synced-folder",
        group: USER,
        owner: USER,
        mount_options: ["dmode=775,fmode=664"]

    end
  end

  config.vm.network "private_network", :type => 'dhcp'

end