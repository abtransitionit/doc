---

heat_template_version: 2018-08-31
description: >
  Tpl@(Ops, Heat) to create:
  -  1 network:admin
  -  1 network:front

# param@input used by resource
parameters:
  ## Network front
  network_front_root_name:
    type: string    
    description: Name of the VLan on VRack:Default
    default:     {{ vn.front.name }}
  network_front_subnet_name:
    type: string    
    description: Name of the VLan:Subnet on VRack:Default
    default:     {{ vn.front.name }}_subnet
  network_front_cidr:
    type: string    
    description: VLan:Ip:Range@possible
    default:     {{ vn.front.cidr }}
  ## Network Admin
  network_admin_root_name:
    type: string    
    description: Name of the VLan on VRack:Default
    default:     {{ vn.name.cidr }}
  network_admin_subnet_name:
    type: string    
    description: Name of the VLan:Subnet on VRack:Default
    default:     {{ vn.name.cidr }}_subnet
  network_admin_cidr:
    type: string    
    description: VLan:Ip:Range@possible
    default:     {{ vn.admin.cidr }}

# resource to create
resources:
  ## network:front
  network_front:
    type: OS::Neutron::Net
    properties:
      name: { get_param: network_front_root_name  }
      port_security_enabled: true
  ## network:admin
  network_admin:
    type: OS::Neutron::Net
    properties:
      name: { get_param: network_admin_root_name  }
      port_security_enabled: true
  ## network:front:subnet
  network_front_subnet:
    type: OS::Neutron::Subnet
    properties: 
      network_id: { get_resource: network_front           }
      name:       { get_param: network_front_subnet_name  }
      cidr:       { get_param: network_front_cidr         }
      dns_nameservers: [ "8.8.8.8", "8.8.4.4" ]
      enable_dhcp: true
      ip_version: 4
  ## network:admin:subnet
  network_admin_subnet:
    type: OS::Neutron::Subnet
    properties: 
      network_id: { get_resource: network_admin           }
      name:       { get_param: network_admin_subnet_name  }
      cidr:       { get_param: network_admin_cidr         }
      dns_nameservers: [ "8.8.8.8", "8.8.4.4" ]
      enable_dhcp: true
      ip_version: 4

# define param@ouput provided by resource creation at runtime
# outputs:
#   vm_ip:
#     description: Vm:Ip after creation
#     value: { get_attr: [mxvm, first_address] }

