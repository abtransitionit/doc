# [Terraform][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md



# on ubuntu 20.04 LTS
- Prerequisit, Requirement
  - vm or container
    - with Os installed
    - accessible via ssh
    - that have access to Internet
- scp following script@bash in /tmp of Vm or container
- ssh vm or container
- play script as user with sudo root

```bash
!# /bin/bash

# Define > Var
## 
ListPackage="jq openssh-server curl unzip"
## 
DF_TF_GIT_URL="https://api.github.com/repos/hashicorp/terraform/releases/latest"
## get Tf:Version.latest
DF_TF_VERSION=$(curl -s ${DF_TF_GIT_URL} | jq -r .tag_name | cut -c2-)
## Define Tf:file@zip:name
DF_TF_ZIP_NAME="terraform_${DF_TF_VERSION}_linux_amd64.zip"
DF_TF_ZIP_URL="https://releases.hashicorp.com/terraform/${DF_TF_VERSION}/${DF_TF_ZIP_NAME}"

# ---- install > Package@Basic
sudo apt install -qq -y ${ListPackage}

# ---- install > Package
## download file@zip
wget -P /tmp ${DF_TF_ZIP_URL}
## unzip at dest
sudo unzip /tmp/${DF_TF_ZIP_NAME} -d /usr/local/bin/
```

# Check install
```bash
# display version
terrrafom -version

# display help
terrrafom -help
terrrafom paln -help


