# Task 1: Introduction
### Deploy the machine. Who is the employee of the month?
Typing in the machine's IP address, we'll get an web page with an image of a man. Inspect the image and we'll get the name of the man as the image's name. If that doesn't work we can always do reverse google image search.

**Bill Harper**
# Task 2: Initial Access
### Scan the machine with nmap. What is the other port running a web server on?
We'll do the usual nmap command.
_nmap -Pn -vv -sV <ip_addr>_
The 2 ports with a web server are 80 and 8080.

**8080 **
### Take a look at the other web server. What file server is running?
We see something, a word, "rejetto". Do a quick google search and we see our answer.

**Rejetto HTTP File Server**
### What is the CVE number to exploit this file server?
#### Hint: [https://www.exploit-db.com/](https://www.exploit-db.com/)
Another quick search. With the hint we get a solid answer if the result we get is right. **"Rejetto HTTP File Server (HFS) 2.3.x - Remote Command Execution (2)"**

**2014-6287**
### Use Metasploit to get an initial shell. What is the user flag?
