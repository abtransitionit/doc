# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Keystone


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Whatis_List]:      ../list/whatis_list.md
[Component_List]:   ../list/component_list.md
[Keystone_Howto]:   ../howto/keystone_howto.md
[Memcached_whatis]: ../whatis/memcached_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[List][Component_List]
|Keystone|[How-to][Keystone_Howto]
|Memcached|[whatis][Memcached_whatis]
<br>

# Definition
Keystone est
  - 1 composant OpenStack

Keystone manage
- Identity Service (i.e authentication, authorization of user)
- Catalog Service (i.e discover service)

Keystone uses
  - **Memcached** to cache tokens in the authentication mechanism for services
  - **MariaDB** to store conf

Keystone is used by
  - End user to   
    - authenticate and use its identity to access other OpenStack:Services
  - Services to  
    - Ensure users are who they say they are 
    - Discover where other services are within the deployment via the use of service catalog

Keystone can use followwing backend as catalog service:endpoint
  - the file : **/etc/keystone/default_catalog.templates**
  - the db   : keystone

# Authentication
- To authenticate 1 user against keystone, you must create a service user for each OpenStack service
  - 1 for Service: compute
  - 1 for Service: block storage
  - 1 for Service: Network

- To configure the OpenStack services with service users
  1. create a project for all services
  1. create users for each service. 
  1. Assign the admin role to each service pair user/project
  1. **This role enables users to validate tokens and authenticate and authorize other user requests.**

# Component
- Server
  - the server
- Driver
  - service backend (e.g SQL Db, LDAP server)
  - Allow 1 domain to have its own LDAP or SQL back end. By default, domain-specific drivers are disabled.
- Module
  - intercept service requests
  - extract user credentials
  - send data to server for authorization


Keystone can  integrate with external identity management system like LDAP

# File@conf
 - **/etc/keystone/default_catalog.templates** defines the endpoints for services
# Bootstrap 
Le bootstrap
  - désigne une sequence d'action de keystone
  - est effectué lors de l'install de keystone
  - créé les objets suivants
    - role: admin, member, reader 
    - project: admin 
    - domain: default

During cloud set up, the operator defines at least one project, user, and role.


# Todo
## Step
- User authenticated via keystone
- User use its identity to access other OpenStack:Services
  - 
Likewise, other OpenStack services leverage the Identity service to ensure users are who they say they are and discover where other services are within the deployment. 


  