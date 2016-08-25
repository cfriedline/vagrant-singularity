S=/usr/local/bin/singularity

singularity_install:
	wget https://github.com/gmkurtzer/singularity/archive/2.1.2.tar.gz
	tar xvf 2.1.2.tar.gz
	cd singularity-2.1.2 && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

create_hpc:
	sudo $S create -F trusty.img
	cp /media/host/trusty.def .
	sudo $S bootstrap trusty.img trusty.def
