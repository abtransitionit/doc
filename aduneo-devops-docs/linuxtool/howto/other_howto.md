# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md




# get field
```bash
openstack network list | awk '/ mxvn-net02 / { print $2 }'
```

# Check Vm:Processor supports hardware acceleration for VM
```bash
# if > 0 = > yes else no
# intel:VT-x or AMD:SVM  
egrep -c '(vmx|svm)' /proc/cpuinfo
```

# display Vm:Os:Core:Version
```bash
cat /proc/version
uname -m
uname -mr

```

# Update Os:Package:Version:latest
```bash
# debian/ubuntu
sudo apt update -y && sudo apt upgrade -y && sudo reboot
```

# Get Vm:Os:Info
```bash
# Def var
MX_HOST_NAME="controler"
#
hostname
hostnamectl
# Update Host:name temporarily
hostnamectl ${MX_HOST_NAME}
# Update Host:name permanently
hostnamectl set-hostname ${MX_HOST_NAME}
hostnamectl set-hostname --pretty ${MX_HOST_NAME}
```

# Get Vm:Info
```bash
# debian/ubuntu
export VM_ARCH=$(dpkg --print-architecture)
# all
export VM_ARCH=$(uname -m)

```
# Get Vm:Os:Info
```bash
# debian/ubuntu/centos
lsb_release -a
# debian/ubuntu/centos
export OS_TYPE=$(lsb_release -cs)
# all
export OS_TYPE=$(uname -s)

```




# Tree Folder:Level
```bash
tree -a -L 3
```
# Todo
```
ping -c 4 ${gNODE_COMPUTE_NAME}
```


# other
```bash
dpkg-reconfigure tzdata
sudo service docker start
sudo usermod -aG docker ec2-user
```

# ssh
## code
```bash
# play cde in bg with no output and no log
ssh controler "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  &>/dev/null &

# play cde in bg with no output but log
nohup ssh controler "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > /tmp/ontroler.log &
```
## code
```yaml
Host proxy
  Hostname proxy.tld
  User proxy_user
Host target
  Hostname target.tld
  User target_user
  ProxyCommand ssh -W %h:%p proxy
```
