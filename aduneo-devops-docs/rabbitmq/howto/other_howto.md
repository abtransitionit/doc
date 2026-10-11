# [RabbitMQ][Topic_Whatis] > [Howto][Howto_List] > use > Cde


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md




# Some Cde

```bash
sudo rabbitmqctl list_exchanges
sudo rabbitmqctl list_bindings
sudo rabbitmqctl list_vhosts
sudo rabbitmqctl list_user_permissions ${lRABBITMQ_USER_NAME}
sudo rabbitmqctl list_permissions -p /myvhost
```

# Login to Ihm
```bash
lServer_IP_RABBITMQ="92.222.22.21"
http://{lServer_IP_RABBITMQ}:15672
```
# Manage User
```bash
# Add User@admin (can connect from remote)
lRABBITMQ_USER_NAME="openstack"
lRABBITMQ_USER_PWD="openstack1@"
sudo rabbitmqctl add_user ${lRABBITMQ_USER_NAME} ${lRABBITMQ_USER_PWD}
sudo rabbitmqctl set_user_tags ${lRABBITMQ_USER_NAME} administrator


# Delete
rabbitmqctl delete_user user

# Update User:Pwd
lRABBITMQ_USER_NAME="openstack"
lRABBITMQ_USER_PWD="openstack1@"
rabbitmqctl change_password ${lRABBITMQ_USER_NAME} ${lRABBITMQ_USER_PWD}
```
