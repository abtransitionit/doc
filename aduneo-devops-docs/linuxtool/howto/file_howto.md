# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > manage > File


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Howto_List]:       ../list/howto_list.md
[Interface_Whatis]: ../whatis/interface_whatis.md


# Create File@Root when User@Sudo
```bash
echo "${gNODE_COMPUTE_IP} ${gNODE_COMPUTE_NAME}" | sudo tee   "${gEtcHostFilePath}" > /dev/null
```

# Add content to File@root when User@Sudo
```bash
echo "${gNODE_COMPUTE_IP} ${gNODE_COMPUTE_NAME}" | sudo tee -a "${gEtcHostFilePath}" > /dev/null
```



