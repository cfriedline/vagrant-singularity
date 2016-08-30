S=/usr/local/bin/singularity
W=sudo $(S) exec -w $(I)
WD=sudo $(S) -d exec -w $(I)
E=$(S) exec $(I)
C=sudo $(S) copy $(I)
B=sudo $(S) bootstrap $(I)

#### target specific variables ####
%_ddocent : I=ddocent.img
%_trusty : I=trusty.img
###################################


trusty: create_trusty bootstrap_trusty setup_python
ddocent: create_ddocent bootstrap_ddocent install_ddocent

sleep:
	sleep 5

singularity_install:
	rm -rf 2.1.2.tar.gz singularity-2.1.2
	wget https://github.com/gmkurtzer/singularity/archive/2.1.2.tar.gz
	tar xvf 2.1.2.tar.gz
	cd singularity-2.1.2 && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

singularity_github:
	rm -rf singularity
	git clone https://github.com/gmkurtzer/singularity.git
	cd singularity && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

shell_trusty:
	$S shell $I

create_trusty: trusty.img
	sudo $S create -s 3072 -f ext4 $I

bootstrap_trusty: create_trusty
	cp /media/host/defs/trusty.def .
	$B trusty.def

env_trusty: sleep
	$C -f /media/host/envs/environment_trusty /environment

install_trusty: env_trusty sleep
	$W conda \
	create -y \
	-n py35 \
	python=3.5 \
	numpy \
	scipy \
	statsmodels \
	scikit-learn \
	jupyter \
	notebook \
	pandas \
	psutil

create_ddocent:
	test -f $I || sudo $S create -s 2048 $I

bootstrap_ddocent: create_ddocent
	cp /media/host/defs/dDocent_centos.def ./ddocent.def
	$B ddocent.def

env_ddocent:
	$C -f /media/host/envs/environment_ddocent /environment


copy_install_script_ddocent:
	$C -f /media/host/scripts/install_ddocent.sh /

install_ddocent: copy_install_script_ddocent
	$(W) /bin/bash /install_ddocent.sh

clean_ddocent: env_ddocent
	$W rm -rf /src /dDocent_run /install

shell_ddocent:
	$S shell $I

upload_ddocent:
	cp $I /media/host

upload_trusty:
	cp $I /media/host

fix_ddocent:
	$W pwd
