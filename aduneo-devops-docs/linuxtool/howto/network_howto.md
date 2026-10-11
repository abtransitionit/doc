# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > Network


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Howto_List]:       ../list/howto_list.md
[Interface_Whatis]: ../whatis/interface_whatis.md
[Network_Whatis]:   ../whatis/network_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Interface|[Whatis][Interface_Whatis]
|Network|[Whatis][Network_Whatis]

# Display Gateway@default
```bash
ip r
```

# Display Ip@Public
```bash
echo $(wget -qO - https://api.ipify.org)
echo $(curl -s https://api.ipify.org)
hostname -I | cut -d' ' -f1
```

# List Network:Interface
```bash
# Ubuntu
ip a
ip a | grep inet | grep -v inet6
ip a | grep inet | grep -v inet6 | tr -s ' ' | cut -d" "  -f-3
ip link show
ls -ial  /sys/class/net/
```

# Configure Network:Interface

```bash
# Ubuntu < 22.04
## update file /etc/network/interfaces

# Ubuntu  22.04
## update file > /etc/netplan/xxx | /etc/netplan/50-cloud-init.yaml
## Restart service > sudo netplan apply
## if pbs => debug > sudo netplan --debug apply
# update file
/etc/netplan/50-cloud-init.yaml
# update file
/etc/netplan/xxx
# update file DNS = X.X.X.X 8.8.8.8
/etc/systemd/resolved.conf
# Restart service
netplan apply
systemctl restart systemd-resolved
```

## Example
```yaml
network:
    version: 2
    ethernets:
        enp0s3:
            dhcp4: false
            addresses: [192.168.1.202/24]
            gateway4: 192.168.1.1
            nameservers:
              addresses: [8.8.8.8,8.8.4.4,192.168.1.1]
```

# Manage port
```bash
# ubuntu - open port:(5672,15672)
sudo ufw allow proto tcp from any to any port 5672,15672
# Is port listening ?
sudo ss -tunelp | grep 15672
```


# Todo
## ufw example
```bash
sudo ufw allow proto tcp from any to any port 11211
sudo ufw allow from container_ip1 to any port 11211
sudo ufw allow from vm2_ip2 to any port 11211
sudo ufw allow from sub/net to any port 11211
sudo ufw allow from 10.147.164.5 to any port 11211
sudo ufw allow from 10.147.164.3 to 172.26.12.173 port 11211 proto tcp
sudo ufw allow from 10.147.164.0/24 to any port 11211
```