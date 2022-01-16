# VAGRANT

The focus of these next sections is documenting the use of Vagrant along `libvirt` provider.

## Install Vagrant on Manjaro/Arch Linux

Instal the main package of Vagrant:

```bash
$ sudo pacman -S vagrant
```

To install the plugin, make sure base-devel is installed and libvirtd.service has been started. Then run:

```
vagrant plugin install vagrant-libvirt
```

##  Using Vagrant

Copy some Vagrantfile example from this resitory and run the following commando in the same folder:

```
vagrant up --provider=libvirt
```

Alternatively you can tell Vagrant to permanently use libvirt as default provider by adding the following environment variable:

```
export VAGRANT_DEFAULT_PROVIDER=libvirt
```

## Documentation

- [Vangrant Documentation](https://www.vagrantup.com/docs)

## Useful links

- [How To Use Vagrant With Libvirt KVM Provider](https://ostechnix.com/how-to-use-vagrant-with-libvirt-kvm-provider/)
- [Base boxes built by benevolent robots](https://roboxes.org/)
- [vagrant-libvirt plugin](https://github.com/vagrant-libvirt/vagrant-libvirt)
- [Vagrant Arch Wiki](https://wiki.archlinux.org/title/Vagrant)
- [Libvirt Arch Wiki](https://wiki.archlinux.org/title/Libvirt)
- [KVM Arch Wiki](https://wiki.archlinux.org/title/KVM)
- [QEMU Arch Wiki](https://wiki.archlinux.org/title/QEMU)



