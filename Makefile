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
ddocent: create_ddocent bootstrap_ddocent gmk_install_ddocent

sleep:
	sleep 5

singularity_install:
	wget https://github.com/gmkurtzer/singularity/archive/2.1.2.tar.gz
	tar xvf 2.1.2.tar.gz
	cd singularity-2.1.2 && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

singularity_github:
	git clone https://github.com/gmkurtzer/singularity.git
	cd singularity && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

shell_trusty:
	$S shell $I

create_trusty:
	test -f $I || sudo $S create -s 3072 -f ext4 $I

bootstrap_trusty: create_trusty sleep
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
	test -f $I || sudo $S create -s 2048 -f ext3 $I

bootstrap_ddocent: create_ddocent
	cp /media/host/defs/ddocent.def .
	$B ddocent.def

env_ddocent:
	$C -f /media/host/envs/environment_ddocent /environment

install_ddocent: env_ddocent
	$(W) bash -c "mkdir -p /install && \
	mkdir -p /dDocent_run && \
	rm -rf /src/dDocent && \
	git clone https://github.com/jpuritz/dDocent.git /install/dDocent && \
	cd /install/dDocent && \
	sed -i s%https://cdhit.googlecode.com/files/cd-hit-v4.6.1-2012-08-27.tgz%https://github.com/weizhongli/cdhit/releases/download/V4.6.1/cd-hit-v4.6.1-2012-08-27.tgz% install_dDocent_requirements && \
	bash install_dDocent_requirements /dDocent_run"
	$W pwd

gmk_install_ddocent:
	$(W) /bin/sh << EOF
		sudo rm -rf /install /dDocent_run && \
		sudo mkdir /install && \
		sudo mkdir /dDocent_run && \
		sudo /usr/bin/git clone https://github.com/jpuritz/dDocent.git /install/dDocent && \
		cd /install/dDocent && \
		sudo sed -i s%https://cdhit.googlecode.com/files/cd-hit-v4.6.1-2012-08-27.tgz%https://github.com/weizhongli/cdhit/releases/download/V4.6.1/cd-hit-v4.6.1-2012-08-27.tgz% install_dDocent_requirements && \
		sudo bash install_dDocent_requirements /dDocent_run
		EOF

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
