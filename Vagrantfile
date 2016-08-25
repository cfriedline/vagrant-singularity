Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get -y install build-essential automake wget libtool vim debootstrap
    sudo mkdir -p /media/cdrom
    sudo mkdir -p /media/host
  SHELL

end
