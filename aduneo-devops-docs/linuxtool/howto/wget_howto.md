# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > use > Wget


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Curl_Howto]:   ../howto/curl_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Curl|[How-to][Curl_Howto]
<br>

# get in folder
```bash
lUrl="cloud-images.ubuntu.com"
lResPath="releases/20.04/release"
lResName="ubuntu-20.04-server-cloudimg-amd64.img"
lPathDst="/var/kvm/images"

wget http://${lUrl}/${lResPath}/${lResName} -P ${lPathDst}
```