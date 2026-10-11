# [Maria DB][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md


# Install on ubuntu 20.04 LTS
```bash

# Define > Var
lControllerNodeIp=$(hostname -I | cut -d' ' | -f1)
lControllerNodeIp="127.0.0.1"
lMariadbConfFileName="/etc/mysql/mariadb.conf.d/99-openstack.cnf"
lListPackageBasic="mariadb-server python3-pymysql"
# Install > Packege
sudo apt install ${lListPackageBasic} -y
# install > package@db
sudo apt install ${lListPackageBasic} -y
# Configure > Db
## Create File
cat <<EOM | sudo tee "${lMariadbConfFileName}" > /dev/null
[mysqld]
bind-address = ${lControllerNodeIp}

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOM

# start
sudo service mysql restart
sudo systemctl enable --now msql

```

# Check Install
```bash
mysql -V
service mysql statuis
```
