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
	sudo $S create -s 2048 -f ext4 -F trusty.img
	cp /media/host/trusty.def .
	sudo $S bootstrap trusty.img trusty.def
	cp trusty.img /media/host

setup_python:
	sudo singularity exec -w trusty.img /miniconda3/bin/conda \
	create -y \
	-n py35 \
	python=3.5 \
	numpy \
	scipy \
	statsmodels \
	scikit-learn \
	jupyter \
	notebook \
	pandas
