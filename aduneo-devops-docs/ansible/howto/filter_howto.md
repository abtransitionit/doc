# [Ansible][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md



# Example
```yaml
- name: Display > Network
  debug:
    msg: 
      # - "{{ result.openstack_networks  }}"
      - "{{ lookup('ansible.utils.to_paths', result.openstack_networks)  }}"
```
