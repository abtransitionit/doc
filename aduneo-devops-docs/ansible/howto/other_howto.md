# [Ansible][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md

# List Collection@installed
```bash
ansible-galaxy collection list
```

# Add Collection (not yet installed)
```bash
# Method
export lCOLLECTION_NAME="openstack.cloud"
ansible-galaxy collection install ${lCOLLECTION_NAME}

# Method
## Create file
export lCOLLECTION_NAME="openstack.cloud"
export lFILE_NAME="requirements.yml"
cat <<EOF >> ${lFILE_NAME}
collections:
- name: ${lCOLLECTION_NAME}
EOF
## Cli
ansible-galaxy collection install -r ${lFILE_NAME}
```