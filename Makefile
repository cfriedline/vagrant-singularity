S=/usr/local/bin/singularity
I=trusty.img
W=$(S) exec -w $(I)
E=$(S) exec $(I)

shell:
	$S shell $I


singularity_install:
	wget https://github.com/gmkurtzer/singularity/archive/2.1.2.tar.gz
	tar xvf 2.1.2.tar.gz
	cd singularity-2.1.2 && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install

create_hpc:
	sudo $S create -s 3072 -f ext4 -F trusty.img

bootstrap_hpc:
	cp /media/host/trusty.def .
	sudo $S bootstrap trusty.img trusty.def

setup_python:
	sudo $W /miniconda3/bin/conda \
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
