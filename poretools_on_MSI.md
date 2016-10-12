# Running `poretools` on MSI

This page contains step-by-step instructions for setting up Python and installing custom modules on MSI. Specifically, these instructions explain how to configure an MSI user's environment to run [poretools](http://poretools.readthedocs.io/en/latest/) to analyze Oxford Nanopore MinION sequencing data.

Steps 4-8 have been automated as a bash script `install_poretools.sh` in this repo. Once you have launched an interactive session:

    cd && git clone https://github.com/jbadomics/msi_nanopore.git
    source ~/install_poretools.sh

1.  Log in to MSI via SSH (requires VPN if off campus):

        ssh username@login.msi.umn.edu

2.  SSH to your node of choice:

        ssh lab		# OR
        ssh mesabi

3.  Launch an interactive session with desired resources and duration:

        qsub -I -q lab -l nodes=1:ppn=16,mem=8gb,walltime=2:00:00 -d $PWD  # on lab nodes
        qsub -I -q small -l nodes=1:ppn=24,mem=16gb,walltime=2:00:00 -d $PWD  # on mesabi

4.  Purge and load modules required by `poretools`:

        module purge
        module load python/2.7.9  # poretools is written for Python >=2.7
        module load gcc/4.9.2
        module load hdf5/hdf5-1.8.14-gcc-4.9.2-serial
        module list
    
    Verify the correct version of Python with
    
        python -V
        
5.  Configure your `PYTHONPATH` variable (add to `~/.bashrc` if desired). This will unset any existing PYTHONPATH settings and guarantee that local module installations overlook MSI-wide installations:

        unset PYTHONPATH
        export PYTHONPATH='~/.local/lib/python2.7/site-packages'

6.  Install `pip` as a generic user, i.e. not as root:

        cd
        wget https://bootstrap.pypa.io/get-pip.py
        chmod +x get-pip.py
        python get-pip.py --user
        
    This will create `~/.local` and install pip, setuptools, and wheel.
        
7.  Add the `pip` executable to your PATH:

        PATH=~/.local/bin:$PATH

8.  Use `pip` to install/upgrade Python module dependencies for poretools, as well as poretools itself:

        pip install --user --upgrade numpy 
        pip install --user matplotlib h5py seaborn pandas poretools
        poretools -h

At this point you should have a working poretools installation!

