# [LibVirt][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md




# on Ubuntu 22.04
```bash
# Check Virtualization is possible
egrep -c '(vmx|svm)' /proc/cpuinfo

# Check Virtualization@Kvm is possible
kvm-ok

# Install Package
lListPackage="qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils"
sudo apt install ${lListPackage} -y

# Start Service
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd

# Grant User tool:usage
sudo usermod -aG kvm     $USER
sudo usermod -aG libvirt $USER
sudo reboot
```
