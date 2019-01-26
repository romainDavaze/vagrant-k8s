# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_VERSION = "2"

NUM_MASTERS = ENV['NUM_MASTERS'] || 1
NUM_NODES = ENV['NUM_NODES'] || 3

user = "vagrant"

Vagrant.configure(VAGRANTFILE_VERSION) do |config|

  # Masters
  (1..NUM_MASTERS.to_i).each do |i|
    config.vm.define "master-#{i}" do |master|
      master.vm.box = "centos/7"
      master.vm.hostname = "master-#{i}"
      master.vm.provider "virtualbox" do |v|
        v.name = "master-#{i}"
        v.memory = 2048
        v.cpus = 1
      end
      master.vm.synced_folder "synced-folder", "/home/#{user}/synced-folder",
        group: user,
        owner: user,
        mount_options: ["dmode=775,fmode=664"]
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
      node.vm.synced_folder "synced-folder", "/home/#{user}/synced-folder",
        group: user,
        owner: user,
        mount_options: ["dmode=775,fmode=664"]
    end
  end

end