Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install build-essential automake wget libtool vim dkms kernel-devel.x86_64
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y install epel-release-latest-7.noarch.rpm
    sudo yum -y install debootstrap
    sudo mkdir -p /media/cdrom
    sudo mkdir -p /media/host
  SHELL

end
