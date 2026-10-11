# [Govc][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Install govc on ubuntu 20.04 LTS
- Prerequisit
  - internet Access needed
- scp following script@bash in /tmp of vm or container
- ssh vm or container
- play script as user with sudo root
```bash
!# /bin/bash

# Define > Var
## 
GOVC_TGZ_NAME="govc_Linux_x86_64.tar.gz"     
GOVC_URL="https://github.com/vmware/govmomi/releases/latest/download/${GOVC_TGZ_NAME}"
GOVC_FOLDER="/usr/local/bin" # must be in $PATH

# ---- install > Package
## download file@tgz
curl -L "${GOVC_URL}" -o "/tmp/${GOVC_TGZ_NAME}"            
sudo tar -C  ${GOVC_FOLDER} -xzf /tmp/${GOVC_TGZ_NAME} govc    
```

# Check install
```bash
# display version
govc version [-l]

# display help
govc 


# list govc:varenv
govc env

# Display datacenter:info@global
govc about

