### How many services are running under port 1000?
_nmap -Pn -sV -vv <ip_addr>_
**2**
### What is running on the higher port?
**ssh**
### What's the CVE you're using against the application?
Use gobuster to look for directories.
_gobuster dir -u <ip_addr> -w /usr/share/wordlists/dirb/common.txt_
found  _/simple_

