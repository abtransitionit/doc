heat_template_version: 2018-08-31
description: >
  Tpl@(Ops, Heat) to create:
  -  1 network:front
  -  1 network:back

# param@input used by resource
parameters:
  ## Network front
  network_front_root_name:
    type: string    
    description: Name of the VLan on VRack:Default
    default:     vn-app
  network_front_subnet_name:
    type: string    
    description: Name of the VLan:Subnet on VRack:Default
    default:     vn-app-subnet
  network_front_cidr:
    type: string    
    description: VLan:Ip:Range@possible
    default:     192.68.0.0/24
  ## Network db
  network_db_root_name:
    type: string    
    description: Name of the VLan on VRack:Default
    default:     vn-db
  network_db_subnet_name:
    type: string    
    description: Name of the VLan:Subnet on VRack:Default
    default:     vn-db-subnet
  network_db_cidr:
    type: string    
    description: VLan:Ip:Range@possible
    default:     192.68.0.0/24
  ## Network Admin
  network_admin_root_name:
    type: string    
    description: Name of the VLan on VRack:Default
    default:     vn-admin
  network_admin_subnet_name:
    type: string    
    description: Name of the VLan:Subnet on VRack:Default
    default:     vn-admin-subnet
  network_admin_cidr:
    type: string    
    description: VLan:Ip:Range@possible
    default:     10.0.0.0/16

# resource to create
resources:
  ## network:front
  network_front:
    type: OS::Neutron::Net
    properties:
      name: { get_param: network_front_root_name  }
      port_security_enabled: true
  ## network:db
  network_db:
    type: OS::Neutron::Net
    properties:
      name: { get_param: network_db_root_name  }
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
  ## network:db:subnet
  network_db_subnet:
    type: OS::Neutron::Subnet
    properties: 
      network_id: { get_resource: network_db           }
      name:       { get_param: network_db_subnet_name  }
      cidr:       { get_param: network_db_cidr         }
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

