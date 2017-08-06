#! /bin/bash
sudo apt-get install git
git clone https://github.com/flex4/behavioral-model
mv behavioral-model bmv2
cd bmv2
./install_deps.sh
./autogen.sh
./configure
make -j8
