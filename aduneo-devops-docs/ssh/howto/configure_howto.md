# [Ssh][Topic_Whatis] > [Howto][Howto_List] > Configure


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Example
```bash
# ~/.ssh/config
Include config.d/*
Host  *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  LogLevel ERROR
  ControlMaster auto
  ControlPath /tmp/mx-ssh-socket-%r@%h-%p
  ControlPersist 600

# ~/.ssh/config.d/ovh
Host ovh*u
  User ubuntu
  IdentityFile /home/dockadm/debug/secret/keysshpriv/ksp.vm.ovh
Host ovh*d
  User debian
  IdentityFile /home/dockadm/debug/secret/keysshpriv/ksp.vm.ovh

# ~/.ssh/config.d/ovh1
Host ovh1*
  HostName 51.210.10.19

# ~/.ssh/config.d/ovh2
Host ovh2*
  HostName 51.77.213.243
```

# Example
```bash
# /etc/hosts
102.23.76.98 rie.qua.maim
102.24.74.98 rie.rec.maim

# ~/.ssh/config
Include config.d/*
Host  *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  LogLevel ERROR
  ControlMaster auto
  ControlPath /tmp/mx-ssh-socket-%r@%h-%p
  ControlPersist 600

# ~/.ssh/config.d/opsdin
Host opsdin*
  User cloudadm
  IdentityFile /home/dockadm/debug/secret/keysshpriv/ksp.vm.ovh

# ~/.ssh/config.d/opsdin_qua_bastion
Host opsdin_qua_bastion
  HostName rie.qua.maim

# ~/.ssh/config.d/opsdin_rec_bastion
Host opsdin_rec_bastion
  HostName rie.rec.maim

```