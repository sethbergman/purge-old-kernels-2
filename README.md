# purge-old-kernels-2
Fork of Ubuntu's 'purge-old-kernels', with a few minor changes in the notes.<br>
Shellscript, meant for Ubuntu and its derivatives like Linux Mint.<br>
<br>
Main reason for its existence: 'purge-old-kernels' has been deprecated because 'apt autoremove' should do this job as well.<br>
But 'apt autoremove' (apt-get autoremove) does much more than just removing old kernels, which might be undesirable.<br>
<br>
This script will <b><i>always</b></i> keep the currently running kernel and its headers, which should make it safe to use.<br>
Default is 2, which means that it keeps one spare kernel besides the currently running kernel.<br>
<b>Before you can use it, you need to make this shell script executable.</b><br>
<br>
Usage:<br>
sudo sh purge-old-kernels-2.sh<br>
<br>
You can change the number of kept kernels with --keep N. For example: sudo sh purge-old-kernels-2.sh --keep 3<br>
