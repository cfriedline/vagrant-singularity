#Vagrant Singularity Setup

## Setup Virtual Machine

```
git clone https://github.com/cfriedline/vagrant-singularity.git
cd vagrant-singularity
vagrant up
vagrant ssh
sudo umount vagrant
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vagrant /media/host
ln -s /media/host/Makefile
make singularity_install
```

## Create Trusty Container

`make trusty`

## Create dDocent Container

`make ddocent`
