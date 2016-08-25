S=/usr/local/bin/singularity
W=sudo $(S) exec -w $(I)
E=$(S) exec $(I)
C=sudo $(S) copy $(I)
B=sudo $(S) bootstrap $(I)

#### target specific variables ####
%_ddocent : I=ddocent.img
%_trusty : I=trusty.img
###################################


trusty: create_trusty bootstrap_trusty env_trusty setup_python
ddocent: create_ddocent bootstrap_ddocent environment_ddocent install_ddocent

singularity_install:
	wget https://github.com/gmkurtzer/singularity/archive/2.1.2.tar.gz
	tar xvf 2.1.2.tar.gz
	cd singularity-2.1.2 && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

shell_trusty:
	$S shell $I

create_trusty:
	test -f $I || sudo $S create -s 3072 -f ext4 $I

bootstrap_trusty: create_hpc
	cp /media/host/trusty.def .
	$B trusty.def

env_trusty:
	$W rm /environment
	$C /media/host/environment_trusty /environment

setup_python: bootstrap_hpc env_trusty
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
	test -f $I || sudo $S create -f ext4 $I

bootstrap_ddocent: create_ddocent
	cp /media/host/ddocent.def .
	$B ddocent.def

env_ddocent:
	$W rm -f /environment
	$C /media/host/environment_ddocent /environment

install_ddocent: env_ddocent
	$W mkdir -p /dDocent_run
	$W mkdir -p /src
	$W rm -rf /src/dDocent
	$W git clone https://github.com/jpuritz/dDocent.git /src/dDocent
	$W bash /src/dDocent/install_dDocent_requirements /dDocent_run

shell_ddocent:
	$S shell $I

upload_ddocent:
	cp $I /media/host

upload_trusty:
	cp $I /media/host
