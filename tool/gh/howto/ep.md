[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/ep.md



<div align="center">

# Tool - Howto - gh

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|


# Create a repo on github
```shell
# define var
lPRJ_NAME="my_prj"
lBRANCH="main"

# create remote repo from scratch
gh repo create "$lPRJ_NAME" --private --remote=origin --push
```

## Todo

```shell
# create remote from local repo
gh repo create "$lPRJ_NAME" --private --source=. --remote=origin --push
```
