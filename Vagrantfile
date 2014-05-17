# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify your local and vagrant ports.
HTTP_HOST = 5555
AUTO_CORRECT = true

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"
 
  # Kick off bootstrap script
  config.vm.provision :shell, :path => "bootstrap.sh"

  # Enable symlinks
  config.vm.provider "virtualbox" do |v|
    ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. If you're using either port a new one will be autoatically used.
  config.vm.network "forwarded_port", guest: '80', host: HTTP_HOST, auto_correct: AUTO_CORRECT

  # Set up a shared folder.
  config.vm.synced_folder "shared/", "/home/vagrant/shared", :mount_options => ['dmode=777,fmode=777']

end
