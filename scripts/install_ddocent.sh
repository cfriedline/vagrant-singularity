#!/usr/bin/env bash

export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
rm -rf dDocent_src
rm -rf /dDocent_run
mkdir -p /dDocent_run
git clone https://github.com/jpuritz/dDocent.git dDocent_src
cd dDocent_src
bash install_dDocent_requirements /dDocent_run
