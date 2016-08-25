## Setup

```
git clone https://github.com/cfriedline/vagrant-singularity.git
cd vagrant-singulatiry
vagrant up
vagrant ssh
sudo umount vagrant
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vagrant /media/host
make -f /media/host/Makefile singularity_install
make -f /media/host/Makefile create_hpc
```
