# SSH
SSH is a network protocol to secure connections between devices, like clients and servers. Because SSH transmits data over encrypted channels, security is at a high level. 
## Prerequisites
Considering a connection with a client and a server, here are the prerequisites:
- An SSH client of your choice
- An SSH server on the remote machine
- The IP address or name of the remote server
## How to Access a Remote Server
To connect to a remote machine, you need its IP address or name and a user. Load the terminal or any SSH client and type ssh command like the following syntax :
```bash
ssh username@hostname_or_ip
```
By default, the port to access the remote machine is 22. It's possible to change the port by accessing the configuration file on the remote. To connect to a remote host with a custom SSH port number, use the -p flag. For example:
```bash
ssh username@hostname_or_ip -p 6969
```
## Improving security with SSH Keys
To avoid brutal force attacks is recommended to disable the password login method and use a pair of ssh keys, one public to put on the server and another private on the client side.
### Create the SSH Keys
The first step is to create the key pair on the client machine:
```bash
$ ssh-keygen
```
You will receive some questions about the place to save the keys and a passphrase to encrypt it. Let them in the suggested place `/home/user/.ssh/` and choose a great passphrase to guarantee the security.
### Copy the Public Key to the Remote Machine
There's an easy command to simplify this process
```bash
$ ssh-copy-id username@hostname_or_ip
```
Alternatively, you can paste in the keys using SSH:
```bash
$ cat ~/.ssh/id_rsa.pub | ssh username@hostname_or_ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
```
### Disable the Password for Root Login
Once you copied the public key to the server, ensured you can log in with those keys. After check that everything is fine, disable the password for root login to increase security. In order to do this, open up the SSH configuration file:
```bash
$ sudo vim /etc/ssh/sshd_config
```
Find the line with `PermitRootLogin` and uncommented it modifying  like this: `PermitRootLogin no`

[10 Actionable SSH Hardening Tips to Secure Your Linux Server](https://linuxhandbook.com/ssh-hardening-tips/)

PermitRootLogin
PasswordAuthentication
PubkeyAuthentication
## SSH LAB
CLIENT
192.168.33.10

SERVER
192.168.33.11
user: root 
password: root

user: normal_user
password: normal_user

user: super_user
password: super_user



