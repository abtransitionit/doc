# [RabbitMQ][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Install on ubuntu 20.04 LTS
```bash
# Define > Var
lListPackage="rabbitmq-server"
lOpenstackUserName="openstack"
lOpenstackUserpwd="maxlafait"
# Update repo
sudo apt update -y
# Upgrade package:version:latest
sudo apt upgrade -y
# Install > Package
sudo apt install ${lListPackage} -y
# Install > Ihm
sudo rabbitmq-plugins enable rabbitmq_management

# Configure > App
## Add user
sudo rabbitmqctl add_user ${lOpenstackUserName} ${lOpenstackUserpwd}
## Add Grant
sudo rabbitmqctl set_permissions ${lOpenstackUserName} ".*" ".*" ".*"
```

# Check Install
```bash
# of service
systemctl is-enabled rabbitmq-server
# of ihm
sudo ss -tunelp | grep 15672
```
