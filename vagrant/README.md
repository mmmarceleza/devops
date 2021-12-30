# VAGRANT

## Install Vagrant on Manjaro/Arch Linux
```bash
$ sudo pacman -S vagrant
```

## Basic commands
First, It is necessary to create a directory for you virtual machine (VM), where a configuration file (`Vagrantfile`) will be saved to manage the configurations.
```bash
$ mkdir [VM FOLDER NAME]
```
Move into your directory:
```bash
$ cd [VM FOLDER NAME]
```
Command to initialize and create a Vagrantfile to a specific VM, also called as BOX in the Vagrant terminology.
```bash
$ vagrant init [BOX NAME]
```
To find the correct name for boxes, search [Vagrant Cloud](https://app.vagrantup.com/boxes/search) for a complete list.

Optionally, you can download a box without creating a Vagrantfile. With the previous command the base image of the box is not download by default. This will happen only when you give the command to run or start the VM (`vagrant up`). If you to download to increase your library of boxes, simply use the following command:
```bash
$ vagrant box add [BOX NAME]
```
Command to run a VM:
```bash
$ vagrant up
```
You can check if the machine is running with this:
```bash
$ vagrant status
```
To access the VM, use ssh:
```bash
$ vagrant ssh
```
To stop the VM, use this:
```bash
$ vagrant halt
```
To destroy the machine:
```bash
$ vagrant destroy
```
This last command do not remove the box, only the VM. In this case, if you want to remove the box, use the following command:
```bash
$ vagrant box remove [BOX NAME]
```
To configure port forwarding you need to modify the Vagrantfile with this line:
```bash
config.vm.network :forwarded_port, guest: 80, host: 4567
```
Reload the VM to take effect.
```bash
$ vagrant reload
```
Once the machine is running again, load `http://127.0.0.1:4567` in your browser, where you will access your application.

## Documentation

- [Vangrant Documentation](https://www.vagrantup.com/docs)

## Useful links

- [How To Use Vagrant With Libvirt KVM Provider](https://ostechnix.com/how-to-use-vagrant-with-libvirt-kvm-provider/)

- [Base boxes built by benevolent robots](https://roboxes.org/)

