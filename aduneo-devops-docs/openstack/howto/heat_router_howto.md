---

# configure:router:rt-admin
## router:admin
lROUTER_NAME="rt-admin"
### step
lNETWORK_NAME="FIP_ADMINISTRATION_RIE"
openstack router set ${lROUTER_NAME} --external-gateway ${lNETWORK_NAME}
### step
lSUBNET_NAME="vn-admin-subnet"
openstack router add subnet ${lROUTER_NAME} ${lSUBNET_NAME}

## router:front
lROUTER_NAME="rt-app"
### step
lNETWORK_NAME="FIP_PUBLICATION_DINUM"
openstack router set ${lROUTER_NAME} --external-gateway ${lNETWORK_NAME}
### step
lSUBNET_NAME="vn-front-subnet"
openstack router add subnet ${lROUTER_NAME} ${lSUBNET_NAME}

## router:interal
###step
lROUTER_NAME="rt_internal"

lNETWORK01_NAME="vn_front"
lNETWORK01_SUBNET_NAME="${lNETWORK02_NAME}_subnet"
lNETWORK01_POR_NAME="${lNETWORK02_NAME}_port"

lNETWORK02_NAME="vn_admin"
lNETWORK02_SUBNET_NAME="${lNETWORK02_NAME}_subnet"
lNETWORK02_POR_NAME="${lNETWORK02_NAME}_port"
### step
openstack port create ${lNETWORK01_POR_NAME} --network ${lNETWORK01_NAME}
openstack port create ${lNETWORK02_POR_NAME} --network ${lNETWORK02_NAME}
### step
openstack router add port ${lROUTER_NAME}   ${lNETWORK01_POR_NAME}
openstack router add port ${lROUTER_NAME}   ${lNETWORK02_POR_NAME}
  
#
ip route add 192.68.2.0/24 via 192.68.1.40
ip route add 192.68.2.0/24 via 192.68.2.83


# heat_server_port:
#     type: OS::Neutron::Port
#     properties:
#       network: { get_resource: heat_network }
#       fixed_ips:
#         - subnet_id: { get_resource: heat_network_subnet }
