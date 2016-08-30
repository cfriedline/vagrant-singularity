S=/usr/local/bin/singularity
I=test.img
W=sudo $(S) exec -w $(I)
WD=sudo $(S) -d exec -w $(I)
E=$(S) exec $(I)
C=sudo $(S) copy $(I)
B=sudo $(S) bootstrap $(I)


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
