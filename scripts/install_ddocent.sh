#!/usr/bin/env bash

export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
rm -rf dDocent_src
rm -rf /dDocent_run
mkdir -p /dDocent_run
git clone https://github.com/jpuritz/dDocent.git dDocent_src
cd dDocent_src
sed -i s%https://cdhit.googlecode.com/files/cd-hit-v4.6.1-2012-08-27.tgz%https://github.com/weizhongli/cdhit/releases/download/V4.6.1/cd-hit-v4.6.1-2012-08-27.tgz% install_dDocent_requirements
bash install_dDocent_requirements /dDocent_run
