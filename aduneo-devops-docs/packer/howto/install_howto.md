# [Packer][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md

# on Os:ubuntu 22.04

## Method
```bash
# Define Var
lPROTO="https"
lURL="apt.releases.hashicorp.com"
lRES_NAME="gpg"
lRES_PATH="${lPROTO}://${lURL}/${lRES_NAME}"
# Add Key@Gpg
curl -fsSL  ${lRES_PATH} | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/haschicorp-packer.gpg > /dev/null
# Add package:apt-add-repository
sudo apt install software-properties-common -y
# Add Repo@Apt
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-add-repository -y "deb [arch=arm64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# Update Repo@Apt
sudo apt update  -qq -y > /dev/null 
# Install Packer
sudo apt-get install packer -y
# Test Install
packer
```

# Method
```bash
# Define Var
lPROTO="https"
lURL="apt.releases.hashicorp.com"
lRES_NAME="gpg"
lRES_PATH="${lPROTO}://${lURL}/${lRES_NAME}"
lGPG_FOLDER="/usr/share/keyrings"
lGPG_NAME="hashicorp-archive-keyring.gpg"
lGPG_PATH="${lGPG_FOLDER}/${lGPG_NAME}"
lREPO_FOLDER="/etc/apt/sources.list.d"
lREPO_NAME="hashicorp.list"
lREPO_PATH="${lREPO_FOLDER}/${lREPO_NAME}"

# Create file - Add Gpg - 6 method
wget -O-    ${lRES_PATH} | gpg --dearmor | sudo tee ${lGPG_PATH} 
wget -O-    ${lRES_PATH} | gpg --dearmor | sudo tee ${lGPG_PATH} > /dev/null
sudo bash -c "wget -O-    ${lRES_PATH} | gpg --dearmor > ${lGPG_PATH}"
curl -fsSL  ${lRES_PATH} | gpg --dearmor | sudo tee ${lGPG_PATH}
curl -fsSL  ${lRES_PATH} | gpg --dearmor | sudo tee ${lGPG_PATH} > /dev/null
sudo bash -c "curl -fsSL  ${lRES_PATH} | gpg --dearmor > ${lGPG_PATH}"

# Create file - Add Repo
echo "deb [signed-by=${lGPG_PATH}] ${lPROTO}://${lURL} $(lsb_release -cs) main" | sudo tee ${lREPO_PATH} > /dev/null

# Update Rpo & Install Package
sudo apt update -qq -y > /dev/null && sudo apt install packer -y
````

