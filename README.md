# purge-old-kernels-2

Fork of Ubuntu's `purge-old-kernels` (part of the byobu package), with a few minor changes in the notes. It's a shell script, meant for Ubuntu and its derivatives like Linux Mint.  

### Main reason for its existence

 - `purge-old-kernels` has been deprecated since Ubuntu 16.04, because `apt autoremove` should do the same job.  

 - But `apt autoremove` (`apt-get autoremove`) does much more than just deleting old kernels. This might be undesirable, which is why some may prefer this precision instrument for removing only old kernels.  

 - Finally, this script is entirely independent from the byobu package, which is an additional advantage: you don't have to install any superfluous software.  

This script will **_always_** keep the currently running kernel and its headers, which should make it safe to use.  
The default is 2, which means that it keeps one spare kernel besides the currently running kernel.  

**Before you can use it, you need to make this shell script executable. See the usage instruction below.**  

### Usage:  

1. Launch a terminal window.  
2. Move the script from the `Downloads` folder to `/opt`, with this command:

```bash
sudo mv -v ~/Downloads/purge-old-kernels-2.sh /opt
```
3. Set the permissions, also making it executable with the following command:

```bash
sudo chmod -v 755 /opt/purge-old-kernels-2.sh
```
4. Launch the script with the following command:

```bash
sudo sh /opt/purge-old-kernels-2.sh
```

### Command line arguments

You can change the number of kept kernels with `--keep N`.
For example:

```bash
sudo sh purge-old-kernels-2.sh --keep 3
```
