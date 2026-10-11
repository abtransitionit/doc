# [Etcd][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Install on ubuntu 20.04 LTS
```bash
# Define > Var
lListPackage="etcd"
lETCD_CON_FILE_PATH="/etc/default/etcd"
# Update repo
sudo apt update -y
# Upgrade package:version:latest
sudo apt upgrade -y
# Install > Package
sudo apt install ${lListPackage} -y
# Configure > App > if necessary
## flag -l
## Start Service
#sudo service memcached restart
```



# Install Client
```bash

```

# Check install
```bash
sudo ss -tunelp | egrep "2379|2380"
etcd --version
etcdctl --version
```
