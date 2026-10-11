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
      networks:
{% for item in lvm.network %}
        - network: {{ item.name }}
{% endfor %}


{% if lvm.sg is defined %}
      # security_groups: [ {{ lvm.sg.name }} ]
      security_groups: [default, {{ lvm.sg.name }} ]
{% endif %}

[ {% for item in lvm.sg %} {{ item }}, {% endfor %}]

# openstack stack list
# openstack stack create {{ stack.name }} -t {{ heat.folder.path }}/{{ heat.file.name }}
# openstack stack delete {{ stack.name }} --yes


