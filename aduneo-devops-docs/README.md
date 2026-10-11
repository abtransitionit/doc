# aduneo-docs

# Purpose
This repoitory@git contains resources
  - in file@markdown
  - that define documentation on following topic:

[//]: #(Reference)
[Ansible_Ep]:   ansible/README
[Docker_Ep]:    docker/README.md
[Etcd_Ep]:      etcd/README.md
[Govc_Ep]:      govc/README.md
[Linux_Ep]:     linuxtool/README.md
[Memcached_Ep]: memcached/README.md
[Mariadb_Ep]:   mariadb/README.md
[Maia_Ep]:      _maia/README.md
[Nubo_Ep]:      nubo/README.md
[Packer_Ep]:    packer/README.md
[Rabbitmq_Ep]:  rabbitmq/README.md
[Terraform_Ep]: terraform/README.md
[Openstack_Ep]: openstack/README.md

|Nom|Tag|
|-|-|
|[Packer][Packer_Ep]||
|[Ansible][Ansible_Ep]|Cloud, Aws, VmWare|
|[Openstack][Openstack_Ep]|Cloud, Aws, VmWare|
|[Linux][Linux_Ep]|Os, Admin|
|[Nubo][Nubo_Ep]|Cloud, Public|
|[Govc][Govc_Ep]|VmWare, Cli, VSphere|
|[Terraform][Terraform_Ep]|Iac, provisioning, Cloud|
|[Docker][Docker_Ep]||
|[Memcached][Memcached_Ep]||
|[Etcd][Etcd_Ep]|KvPair|
|[RabbitMQ][Rabbitmq_Ep]|Msg|
|[MariaDB][Mariadb_Ep]|Db, Rdb|
|[LinuxTool][Linux_Ep]|Os|
|...|...|

# SubFolder:content

1 **folder** per **topic** + 

|Nom|Tag|Description|
|-|-|-|
|_env|Folder|documente une démarche devops pour créer 1 environnement au sein du datacenter Aduneo|
|_todo.md|Fichier@md|<li>Liste de topic à documenter dans ce Git</li><li>liste de référence@externe vers ces topics</li>|
|_terminology.md|Fichier@md|Liste de definitions, de termes, Shared, Common, |
|README.md|Fichier@md|Ce fichier|

# A savoir
La notation suivante est utilisée dans la documentation.

|Syntax|Signification|
|-|-|
|Module@Root|Module de type Root|
|Var@Environnement|Variable de type environement|
|...|
|xx@yy|xx de type yy|
<br>

# Todo
## List doc to do
|Name|Tag|Url|
|-|-|-|
|grafana||https://linoxide.com/how-to-install-grafana-on-ubuntu/
|Juju||<li>doc: https://github.com/juju/juju</li><li>Context: Openstack, install</li>
|lxd||<li>https://linuxcontainers.org/lxd/</li>
|Hashicorp Vault||https://www.youtube.com/watch?v=ffz1tY_8vgE
|Grafana loki||https://go2.grafana.com/loki-grafana-cloud.html?src=ggl-s&mdm=cpc&camp=nb-loki-exact&cnt=124221004773&trm=loki%20log%20aggregation&device=c&gclid=CjwKCAjw6MKXBhA5EiwANWLODIHHSDkRQAYUiDkjR87xdxmKVtgTxstn5E4CLNv_-TA54EsTqMPa5xoCSrIQAvD_BwE
|||https://grafana.com/oss/loki/
|||https://github.com/grafana/loki
|||https://linuxfr.org/news/loki-centralisation-de-logs-a-la-sauce-prometheus

## Todo
- remove doc memcached from openstack