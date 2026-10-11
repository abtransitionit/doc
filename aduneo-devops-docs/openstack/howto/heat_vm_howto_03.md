---

heat_template_version: 2018-08-31
description: >
  Tpl@(Ops, Heat) to create:
  -  1 vm

# resource to create
resources:
  ## vm
  vm_{{ lvm.id }}:
    type: OS::Nova::Server
    properties:
      name:        {{ lvm.name    }}
      key_name:    {{ lvm.keyssh  }}
      image:       {{ lvm.image   }}
      flavor:      {{ lvm.flavor  }}
      user_data:   /var/tmp/userdata.sh
      # user_data:   |
      #   #!/bin/bash
      #   echo "Running boot script"
      #   sudo touch ${HOME}/MyFile
      networks:
{% for item in lvm.network %}
        - network: {{ item.name }}
{% endfor %}
{% if lvm.sg is defined %}
      security_groups: {{ lvm.sg  }}
{% endif %}
        

# openstack stack list
# openstack stack create {{ stack.name }} -t {{ heat.folder.path }}/{{ heat.file.name }}
# openstack stack delete {{ stack.name }} --yes
# openstack console log show {{ lvm.name }}

