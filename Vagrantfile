Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", inline: <<-SHELL
    echo "provisioning..." && \
    sudo apt-get -y install \
        git \
        yum \
        build-essential \
        automake \
        wget \
        libtool \
        debootstrap \
        vim && \
    sudo mkdir -p /media/cdrom && \
    sudo mkdir -p /media/host
  SHELL

end
