---

heat_template_version: 2018-08-31
description: >
  Tpl@(Ops, Heat) to create:
  -  1 network

# resource to create
resources:
  ## network
  network_{{ lvn.id }}:
    type: OS::Neutron::Net
    properties:
      name: {{ lvn.name }}
      port_security_enabled: true
  ## network:subnet
  network_{{ lvn.id }}_subnet:
    type: OS::Neutron::Subnet
    properties: 
      network_id: { get_resource: network_{{ lvn.id }}           }
      name:       {{ lvn.subnet.name }}
      cidr:       {{ lvn.cidr }}
      dns_nameservers: {{ lvn.dns }}
      ip_version: 4

# openstack network list --long -f json | jq .[] | jq .Name
# openstack port list
# openstack subnet list

# Each Network => 2 Port (for Load balanced DHCP Server)

# openstack stack list
# openstack network  list --long -c Name -c Status -c State -c "Network Type" -c "Router Type"
# openstack subnet list --long -c Name -c Subnet -c Gateway -c  DHCP -c 'Name Servers' -c 'Host Routes' -c 'Service Types'
# openstack subnet list --long -c Name -c Subnet -c Gateway  -c 'Allocation Pools' | grep -v "::"

# openstack stack create {{ stack.name }} -t {{ heat.folder.path }}/{{ heat.file.name }}
# openstack stack delete {{ stack.name }} --yes
