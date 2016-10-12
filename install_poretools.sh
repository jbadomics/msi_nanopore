#!/bin/bash

# load module files required by poretools
module purge
module load python/2.7.9
module load gcc/4.9.2
module load hdf5/hdf5-1.8.14-gcc-4.9.2-serial

# unset PYTHONPATH variable to overlook system-wide python package installations
unset PYTHONPATH
export PYTHONPATH='~/.local/lib/python2.7/site-packages'

# download and run get-pip.py to install pip as generic user
cd ~
wget https://bootstrap.pypa.io/get-pip.py > /dev/null 2>&1
chmod +x ~/get-pip.py
echo 'installing pip...'
python ~/get-pip.py --user --quiet
echo 'done.'

# append PATH variable with path to local python package executables
PATH=~/.local/bin:$PATH

# install poretools dependencies and poretools itself
echo 'installing poretools dependencies...'
pip install --user --upgrade numpy > /dev/null 2>&1
pip install --user matplotlib h5py seaborn pandas poretools > /dev/null 2>&1
echo 'done.' && echo

# test for successful installation
if poretools -h > /dev/null ; then
	echo 'poretools installation completed successfully' && echo
fi
