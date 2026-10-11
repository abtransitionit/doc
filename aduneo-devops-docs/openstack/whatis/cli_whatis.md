# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Cli:openstack


[//]: #(Reference)
[Topic_Whatis]:  ../README.md
[Whatis_List]:   ../list/whatis_list.md
[Cli_Howto]:     ../howto/cli_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Cli|[How-to][Cli_Howto]
<br>


# Definition
la cli **openstack** permet
  - d'agir sur 1..N cloud@OpenStack
  - d'effectuer toutes les actions que perrmet l'API de chaque service (e.g keystone, glance, ...)
    - exeption: certaine cli n'écéssite d'installer un plugin ()

# ConFile

Cli look for followwinfg files:

|Oder|Name|Tag|Folder|Description
|-|-|-|-|-|
|-|xxx-openrc.sh|-|<li>~/.config/openstack</li><li>/etc/openstack</li>|
|-|clouds.yaml|-|<li>~/.config/openstack</li><li>/etc/openstack</li>|
|-|clouds-public.yaml|-|<li>~/.config/openstack</li><li>/etc/openstack</li>|

# Argument
|Key|Value|Tag|Description|
|-|-|-|-|
|--os-user-domain-name| \<auth-user-domain-name\>||Domain name containing user
| --os-user-domain-id| \<auth-user-domain-id\>||Domain ID containing user
|--os-trust-id| \<trust-id\>||ID of the trust to use as a trustee user
|--os-default-domain| \<auth-domain\>||Default domain ID (Default: ‘default’)

# Cli:plugin
- openstack:cli can be extended with cde@plugin
- pbs: completion for this cde@plugin not exists
# Toknow
- Client on wich is installed Cli can connect to cloud@openstack via token or login/pwd

