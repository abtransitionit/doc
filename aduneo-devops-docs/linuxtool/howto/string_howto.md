# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > manage > String


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Howto_List]:       ../list/howto_list.md
[Interface_Whatis]: ../whatis/interface_whatis.md


# Replace N spaces by 1 space
```bash
... | tr -s ' '
```

# String Substitution

```bash
## replace char
src="AxxBCyyyDEFzzLMN"
dst=${src//[xyz]/_}
```
