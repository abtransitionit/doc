# [Linux Tool][Topic_Whatis] > [Whatis][Whatis_List] > Time zone


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Whatis_List]:  ../list/whatis_list.md
[Chrony_Howto]: ../howto/chrony_howto.md


# File@conf

|Name|Tag|Description|
|-|-|-|
|/etc/localtime|File
|/usr/share/zoneinfo|Folder
<br>

# Howto
```bash
timedatectl
timedatectl list-timezones
ls -l /etc/localtime
sudo timedatectl set-timezone Europe/Paris
ls -l /etc/localtime
```