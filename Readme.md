#Vagrant Singularity Setup

## Setup Virtual Machine

```
git clone https://github.com/cfriedline/vagrant-singularity.git
cd vagrant-singularity
vagrant up
vagrant ssh
sudo umount /vagrant
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vagrant /media/host
ln -s /media/host/Makefile
cat /media/host/scripts/.bashrc >> .bashrc
make singularity_github #(or singularity_install)
```

## Create Trusty Container

create: `make trusty`

upload: `make upload_trusty`, then `scp` to your HPC

## Create dDocent Container

create: `make ddocent`

upload: `make upload_ddocent`, then `scp` to your HPC

exec:
```
cd /path/to/files
singularity exec /path/to/ddocent.img dDocent

```
