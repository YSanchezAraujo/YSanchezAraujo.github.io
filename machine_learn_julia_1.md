# Preliminaries: Installing Julia

Before we can go about doing anything we'll first need to install the tools that will allow us to conduct our work. Here I'll briefly give a step by step account of how to install Julia for Linux based operating systems, and I'll give a pointer to Mac and Windows Based systems, as those come with ready-made installers so to speak. 

OK, so to start off, we'll need to actually get the software, to do that please see this link 

[Julia page](https://julialang.org/downloads/)

if you have Apple and Windows based computers go ahead and download the files from the links and the installation should be pretty straight forward. However if you're on a Linux machine using say, Ubuntu or Debian then download the "generic linux binaries". If you're wondering if you should pick the 32 bit or 64 bit files, then probably the best way to figure this out is to google "how to check if computer is 32 bit or 64 bit". If I had to guess though, you probably have a 64 bit computer. Anyways, once you've downloaded the file follow the instructions below, **NOTE** you'll need to start up a terminal for this: 

```bash
cd /path/to/where/it/downloaded # replace this with the location of your download path
# now we need to decompress the files
# the command will look something like: tar -xvf julia-<version_info>.tar.gz
# for me the command is (and again this will depend on the 
# version of julia and where you downloaded the file to)
tar -xvf julia-1.0.1-linux-x86_64.tar.gz
# now we're going to go to your home directory
cd ~
# ls and see if a directory of "bin" is there
# if not create one
mkdir bin
# now move the julia folder that you downloaded to this directory
mv ~/Downloads/julia-1.0.1 bin/
# now we're going to create a short mapping in your systems .bashrc file so that it knows where to look for the binary

```
