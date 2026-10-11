# [Docker][Topic_Whatis] > [Howto][Howto_List] > Install


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md



# on Os:ubuntu 22.04

## Method
```bash
```bash
lHostRemoteName="o1u"
lHostRemoteName="vmw-bastion"
lHostRemoteName="ovhops_front"
lListPackage="tree docker.io docker-compose"
lLogPathName="/tmp/${lHostRemoteName}.log"
lUserSudoName="support"
lUserSudoName="ubuntu"
# Chek value before
ssh ${lHostRemoteName} "uname -a | cut -d' ' -f3 | cut -d'-' -f2"

# Upgrade Os
nohup ssh ${lHostRemoteName} "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > ${lLogPathName} &

# Chek value after - must be 41
ssh o1u "uname -a | cut -d' ' -f3 | cut -d'-' -f2"

# Install package - ubuntu denote user@sudo on remote
nohup ssh ${lHostRemoteName} "sudo apt install ${lListPackage} -y && sudo usermod -aG docker ${lUserSudoName} && sudo reboot" > ${lLogPathName} &
```
## Method
```bash
# Docker
sudo apt install -y docker.io
# Docker-compose
sudo apt install -y docker-compose
# Grant user@(sudo, current) to play cli:docker
sudo usermod -aG docker $USER
# Reboot - for grant to take effect
sudo reboot
```


# on Os:ubuntu 20.04
```bash
# Install package@needed
lListPackage="gnupg software-properties-common"
sudo apt install ${lListPackage} -y
# Install key@gpg - check install with apt-key list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add repo@package
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# update repo@package
sudo apt update -y
# Update Package:All to version latest
apt upgrade -y
# install package
sudo apt install docker.io -y
# start service & enable at reboot
sudo systemctl enable --now docker
# grant user to use docker
sudo usermod -aG docker ${USER}
```

# Install Docker-compose on linux/x86_64
```bash
# define var
lIp="github.com"
lResPath="docker/compose/releases/download/1.29.2"
lResName="docker-compose-Linux-x86_64"
lFileDstFolder="/usr/local/bin"
lFileDstName="docker-compose"
lFileDstPath="${lFileDstFolder}/${lFileDstName}"
lUrl="https://${lIp}/${lResPath}/${lResName}"
# Update repo@Package
sudo apt update -y
# Update Package to version latest
sudo apt upgrade -y
# Install
sudo curl -L ${lUrl} -o ${lFileDstPath}
sudo chmod +x ${lFileDstPath}
```
# todo
## Install Docker - Method
```bash
lFileName="docker.list"
lFileFolder="/etc/apt/sources.list.d"
lFilePath="${lFileFolder}/${lFileName}"
lUrl01="https://download.docker.com/linux/ubuntu"
lUrl02="https://download.docker.com/linux/ubuntu/gpg"
echo "deb [arch=amd64] ${lUrl01} ${VERSION_CODENAME} stable" | sudo tee ${lFilePath};
sudo wget --quiet -O - ${lUrl02} | sudo apt-key add -
sudo apt-get update -y;
```
