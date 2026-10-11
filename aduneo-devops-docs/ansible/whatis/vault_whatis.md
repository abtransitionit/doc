# [Ansible][Topic_Whatis] > [Whatis][Whatis_List] > Ansible-vault


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Vault_Howto]:        ../howto/cli_howto.md
[Module_Whatis]:      ../whatis/module_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Vault|[How-to][Vault_Howto]
<br>

# Definition
ansible-vault
  - is 1 cli
  - allow to encrypt/decrypt string/file
  - need 1 passsword to encrypt/decrypt 

# Password:Member
- label
  - document which password you use)
  - e.g: dev, prod, 
- source 
  - document where the password is
  - e.g: prompt, file, script

# vault password client script. 
- is1 file@script
- is used to retrieve ppwd from 1 manager@secret
# Toknow
The passsword can be stored in 
  - 1 manager@secret
    - e.g: system keyring, db, manager@secret
  - 1 file@txt

If password is stored in manager@secret: ansible-vault need 1 vault password client script to retrieve them from within Ansible.

# todo

