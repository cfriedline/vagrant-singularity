## Setup

```
git clone https://github.com/cfriedline/vagrant-singularity.git
cd vagrant-singulatiry
vagrant up
vagrant ssh
sudo umount vagrant
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vagrant /media/host
ln -s /media/host/Makefile
make singularity_install
make create_hpc
make bootstrap_hpc
make setup_python
```

## Remove the /bin/sh link to dash

```
sudo singularity exec -w trusty.img dpkg-reconfigure dash
# choose no when asked to set dash as default shell
```
