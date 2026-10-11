# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Use > Barbican

[//]: #(Reference)
[Topic_Whatis]:    ../README.md
[Howto_List]:      ../list/howto_list.md
[Barbican_Whatis]: ../whatis/barbican_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Barbican|[Whatis][Barbican_Whatis]|
<br>

# Put
```bash
# Example
openstack secret store 
  -n appcred 
  --payload '{"auth_type": "v3applicationcredential", "auth": {"auth_url": "{Keystone_URL}", "application_credential_id": "{ID}", "application_credential_secret": "{SECRET}"}}'

# Example
openstack secret store 
  -n mysecretname 
  -p 'my secret value'  
```

# Get
```bash

openstack secret get my secret value
http://localhost:9311/v1/secrets/a70a45d8-4076-42a2-b111-8893d3b92a3e 
--payload 
-f value

```
