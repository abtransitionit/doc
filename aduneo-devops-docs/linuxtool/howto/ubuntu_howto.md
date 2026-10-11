# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > use > Curl


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md

# Download file
```bash
# define var
lIp="github.com"
lPath="docker/compose/releases/download/1.25.4/"
lRes="docker-compose-$(uname -s)-$(uname -m)"
lFileDstFolder="/usr/local/bin"
lFileDstName="docker-compose"
lFileDstPath="${lFileDstFolder}/${lFileDstName}"

# action
curl -L https://${lIp}/${lPath}/${lRes} -o ${lFileDstPath}
```
