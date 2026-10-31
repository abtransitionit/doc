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
```sh
lPRJ_OWNER="abtransitionit"
lPRJ_NAME="go-tutorial"
lPRJ_DESC="a practical guide to GO code"

# create remote repo from scratch
gh repo create "${lPRJ_OWNER}/${lPRJ_NAME}" --private --description "${lPRJ_DESC}"
```
```shell
# define var
lPRJ_NAME="go-tutorial"
lBRANCH="main"

# create remote repo from scratch
gh repo create "$lPRJ_NAME" --private --remote=origin --push
```

## Todo

```shell
# create remote from local repo
gh repo create "$lPRJ_NAME" --private --source=. --remote=origin --push
```
