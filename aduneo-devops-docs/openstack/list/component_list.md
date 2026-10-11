# [Openstack][Topic_Whatis] > [List][List_List] > Composant


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[List_List]:  ../list/list_list.md
[Component_Whatis]:   ../whatis/component_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[Whatis][Component_Whatis]
<br>


# List
|Name|Type01|Type02|Type03|Tag|Description|
|-|-|-|-|-|-|
|Nova|Services|Compute|Compute Service|Core|<li>Manage (i.e start, stop, ..) Instance</li<li>Manage (i.e schedule, create, delete) compute, access</li><li>Manage compute</li>
|Zun|Services|Compute|Containers Service
|Ironic|Services|Hardware Lifecycle
|Cyborg|Services|Bare Metal Provisioning Service
|Swift|Services|Storage|Object store|core|<li>Store, Get Object</li><li>Object Storage</li>|
|Cinder|Services|Storage|Block Storage|Core|<li>Store Data</li><li>Block Storage</li>|
|Manila|Services|Storage|Shared filesystems
|Neutron|Services|Networking|Networking|Core|<li>connect Network</li><li>Manage Network</li>|
|Octavia|Services|Networking|Load balancer
|Designate|Services|Networking|DNS service
|Keystone|Services|Shared Services|Identity service|core|Manage Authentication, Authorization
|Placement|Services|Shared Services|Placement service
|Glance|Services|Shared Services|Image service|Core|<li>Manage (i.e Store, Get) Vm:Image</li><li>Image:Registry</li>
|Barbican|Services|Shared Services|Key management
|Heat|Services|Orchestration||Big Tent|<li>Orchestration</li><li>Orchestrate resource</li>
|Senlin|Services|Orchestration|Clustering service
|Mistraal|Services|Orchestration|Workflow service
|Zaqar|Services|Orchestration|Messaging Service
|Blazar|Services|Orchestration|Resource reservation service
|Aodh|Services|Orchestration|Alarming Service
|Magnum|Services|Workload Provisioning|Container Orchestration Engine Provisioning
|Sahara|Services|Workload Provisioning|Big Data Processing Framework Provisioning||<li>mass treatement</li>|
|Trove|Services|Workload Provisioning|Database as a Service|Big tent|<li>Db</li>|
|Masakari|Services|Application Lifecycle|Instances High Availability Service
|Murano|Services|Application Lifecycle|Application Catalog
|Solum|Services|Application Lifecycle|Software Development Lifecycle Automation
|Freezer|Services|Application Lifecycle|Backup, Restore, and Disaster Recovery
|Ec2api|Services|API Proxies|EC2 API proxy
|Horizon|Services|Web frontends|Dashboard|Big Tent|<li>Dashboard</li><li>Gui</li>|
|Skyline|Services|Web frontends|Next generation dashboard (tech preview)
|CEILOMETER|Tooling|Monitoring services|Metering & Data Collection Service|Big tent|<li>collect metrics</li><li>Metering</li>|
|PANKO|Tooling|Monitoring services|Event, Metadata Indexing Service
|MONASCA|Tooling|Monitoring services|Monitoring
|WATCHER|Tooling|Resource optimization|Optimization Service
|VITRAGE|Tooling|Resource optimization|Root Cause Analysis service
|ADJUTANT|Tooling|Billing / Business Logic|Operations processes automation
|CLOUDKITTY|Tooling|Billing / Business Logic|Billing and chargebacks
|RALLY|Tooling|Testing / Benchmark|Benchmarking tool
|TEMPEST|Tooling|Testing / Benchmark|The OpenStack Integration Test Suite
|PATROLE|Tooling|Testing / Benchmark|The OpenStack RBAC Integration Test Suite
|STORLETS|Add on|Swift add-ons|Computable object storage
|KURYR|Integration|Container|OpenStack Networking integration for containers
|TACKER|Integration|RNFV|NFV Orchestration
|TRIPLEO|Lifecycle management|Frameworks for lifecycle management|Deploys OpenStack using OpenStack itself
|OPENSTACK-HELM|Lifecycle management|Frameworks for lifecycle management|Deploys OpenStack in containers using Helm
|KOLLA-ANSIBLE|Lifecycle management|Frameworks for lifecycle management|Deploys OpenStack in containers using Ansible
|KAYOBE|Lifecycle management|Frameworks for lifecycle management|Deployment of containerised OpenStack to bare metal
|OPENSTACK-ANSIBLE|Lifecycle management|Frameworks for lifecycle management|Ansible playbooks to deploy OpenStack
|OPENSTACK-CHARMS|Lifecycle management|Frameworks for lifecycle management|Deploys OpenStack in containers using Charms and Juju
|BIFROST|Lifecycle management|Frameworks for lifecycle management|Ansible playbooks using ironic
|OPENSTACK-CHEF|Lifecycle management|Frameworks for lifecycle management|Chef cookbooks to build, operate and consume OpenStack
|LOCI|Packaging recipes for popular frameworks|Lightweight OCI containers
|PUPPET-OPENSTACK|Packaging recipes for popular frameworks|Puppet modules to deploy OpenStack
|RPM-PACKAGING|Packaging recipes for popular frameworks|RPM package specs to deploy OpenStack
|OPENSTACKCLIENT|Client|CLI|Command-line interface for all OpenStack services
|OPENSTACKSDK|Client|SDK|Official Python SDK for OpenStack APIs
<br>



# Keystone:Identity
- The Identity service provides authentication services for each OpenStack service
- The authentication service uses a combination of 
  - domains
  - projects
  - users
  - roles.





# reference
- https://www.openstack.org/software/project-navigator/openstack-components#openstack-services


<br>
