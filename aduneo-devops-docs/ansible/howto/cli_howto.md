# [Ansible][Topic_Whatis] > [Howto][Howto_List] > Cli


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:   ../list/howto_list.md
[Vault_Whatis]: ../whatis/vault_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Vault|[Whatis][Vault_Whatis]
<br>

# Use Cli:Ansible-vault
## Encrypt 1 String
```bash
## Pwd used to encrypt is in 1 file@txt
lPWD_FILE_PATH="/tmp/anspwd"
## String@uncrypted
lSTRING_TO_ENCRYPT="Concealed"
## File that will contains the string@crypted
lSTRING_CRYPTED_FILE_PATH="/tmp/strcrypted"
## Action
ansible-vault encrypt_string ${lSTRING_TO_ENCRYPT} --vault-password-file ${lPWD_FILE_PATH} > ${lSTRING_CRYPTED_FILE_PATH}
```

## Encrypt/Decrypt all file (in place) in 1 folder 
```bash
# Encrypt all file:ves*
ansible-vault encrypt ves*
```
## Encrypt/Decrypt 1 file in place
### Method
```bash
# Define Var
## File@uncrypted
lFILE_TO_ENCRYPT="/tmp/ve.opsrc.ovh.mx.gr9.sh"
lFILE_TO_ENCRYPT="/tmp/ksp.vm.ovh"
# Action
## Encrypt file - you will be prompted to enter pwd
ansible-vault encrypt ${lFILE_TO_ENCRYPT}
cat ${lFILE_TO_ENCRYPT}
## Decrypt File - you will be prompted to enter pwd
ansible-vault decrypt ${lFILE_TO_ENCRYPT}
cat ${lFILE_TO_ENCRYPT}
```



## Dispaly 1 String
ansible-vault view 

## Decrypt 1 String
```bash
## Pwd used to encrypt the String
lPWD_FILE_PATH="/tmp/anspwd"
## File that contains the string@crypted
lSTRING_CRYPTED_FILE_PATH="/tmp/strcrypted"
## Action - Display String@uncrypt to stdout
## Action - Save String@uncrypt to file

```


## create 1 vault password client script:
- Create a file ending with "-client" or "-client.xxx"
- chmod +x the file
- Within the script itself:
  - Print the passwords to standard output
  - Accept a --vault-id option
  - If the script prompts for data (for example, a database password), display the prompts to the TTY.


# Use Cli:Ansible-Playbook
```bash
ansible-playbook playbook.yml --tags test01
ansible-playbook playbook.yml --skip-tags goodbye
ansible-playbook --vault-password-file /tmp/anspwd -i host.yml -u xxx -b playbook.yml
```
# Use Cli:Ansible
```bash
# generic - pattern denote specific host
ansible [pattern] -m [module] -a "[module options]"
# 
ansible --one-line localhost -m ping 
ansible --one-line localhost -m ping  
ansible --one-line webservers -m service -a "name=httpd state=restarted"
ansible --one-line localhost  -m ansible.builtin.shell -a 'echo $TERM'
ansible --one-line localhost  -m ansible.builtin.copy  -a  '...'
ansible            localhost  -m ansible.builtin.setup
```

## Mapping between Ansible:Cli and Ansible:Playbook
```bash
ansible webservers -m ansible.builtin.service -a "name=httpd state=restarted"
ansible atlanta    -m ansible.builtin.copy    -a "src=/etc/hosts dest=/tmp/hosts"
ansible webservers -m ansible.builtin.file    -a "dest=/srv/foo/b.txt mode=600 owner=mdehaan group=mdehaan"
```


## Display facts
```bash
ansible            localhost  -m ansible.builtin.setup
```
## Other
```bash
# ansible testservers --list -i ansible_hosts
# ansible testservers -m command -a uptime -i ansible_hosts
# ansible testservers -m command -a "uname -a" -i ansible_hosts
# ansible-playbook AnsibleWorkSpace/ansible-command-ex1.yml -i ansible_hosts
```

## openstack
```bash
# use env@(ops, current)
ansible            localhost  -m openstack.cloud.compute_flavor_info

```


ansible-vault create --vault-id test@anspwd ve.opsrc.ovh.mx.gr9.sh

```bash
# Create file@(txt, encrypt):output.yml from file@(txt, ):input with pwd:root
ansible-vault create --vault-id test@multi_password_file foo.yml
ansible-vault create --vault-id my_new_password@prompt   foo.yml

TODO : ansible-vault --vault-id label@source
```