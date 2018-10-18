# Preliminaries: Installing Julia

Before we can go about doing anything we'll first need to install the tools that will allow us to conduct our work. Here I'll briefly give a step by step account of how to install Julia for Linux based operating systems, and I'll give a pointer to Mac and Windows Based systems, as those come with ready-made installers so to speak. 

OK, so to start off, we'll need to actually get the software, to do that please see this link 

[Julia page](https://julialang.org/downloads/)

if you have Apple and Windows based computers go ahead and download the files from the links and the installation should be pretty straight forward. However if you're on a Linux machine using say, Ubuntu or Debian then download the "generic linux binaries". If you're wondering if you should pick the 32 bit or 64 bit files, then probably the best way to figure this out is to google "how to check if computer is 32 bit or 64 bit". If I had to guess though, you probably have a 64 bit computer. Anyways, once you've downloaded the file follow the instructions below, **NOTE you'll need to start up a terminal for this**: 

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
# now we're going to create a short mapping in your systems 
# .bashrc file so that it knows where to look for the binary
# you will need to open this file via gedit or vim or whichever
# text editor you have available
# add the followng line in the file
alias julia="/home/yoel/bin/julia-1.0.1/bin/julia"
# again remember to change that path so that it's the one for your system!
# once you've done this save and close the file and source your .bashrc again: 
source ~/.bashrc
# now we should be able to start up julia type "julia" in your terminal: 
julia
```

and viola! if you've gotten this far then the interpreter for Julia should have started up and you should be met with: 

```julia
julia>
```
Alright that's great and all but now we need to continue to download and install software although don't fret this time it will be a far less involved process. From the Julia terminal (that is after you've started up the interperter), **assuming you're using Julia version 1.x**, that is to say version 1 and above, you'll need to do the following to install packages. Actually before you do that, a very brief description of a package. As I've noted before you're installing additional software on your machine, and so, a package is some bundle of code put together by someone else specifically for the Julia programming language. This bundle of code carries with it some functionality that makes life easier for us. So how exactly does it make life easier for us? Well, because we don't have to write the code ourselves! Anyways, to get away from giving explanations that probably don't need to be given, let's continue on. 

```julia
using Pkg
Pkg.add.(["DataFrames", "Distributions", "GLM", "MixedModels", "Conda", "PyPlot"])
using Conda
Conda.add("scipy") # we'll need this for plotting
```
