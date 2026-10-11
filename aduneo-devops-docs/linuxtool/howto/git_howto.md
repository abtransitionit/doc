# [Linux Tool][Topic_Whatis] > [Howto][Howto_List] > Git


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Chrony_Whatis]: ../whatis/chrony_whatis.md

<br>

# Display all file
```bash
git rev-list --objects --all |   \
git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
sort --reverse --numeric-sort --key=3| grep neopage
```

# remove file in repo from os:ubuntu
```bash
# Install jre
sudo apt install default-jre -y
# download bfg
wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
# rename it
mv bfg-1.14.0.jar bfg.jar
# get repo
lTOKEN="xxx"
git clone --mirror https://xxx:${lTOKEN}@git.aduneo.com/client-dinum/dinum-docker.git
# Clean file
java -jar /tmp/bfg.jar --delete-files jason.war dinum-docker.git
# check file is deleted
cd dinum-docker.git
git rev-list ...
# clean folder
git reflog expire --expire=now --all && git gc --prune=now --aggressive
# Unprotect branch or allow force push
repo > settings > repository > protected branches > ...
# push
git push
# Protect branch or disallow force push
repo > settings > repository > protected branches > ...
```

# Howto push to 1..N Repo
- Use *git remote*
- this commande update file .git/config
## add 1 repo@remote
```bash
## Add 1 repo@remote [in .git/config]
git remote add ${REPO_REMOTE_NAME} ${REPO_REMOTE_URL}
## Delete 1 repo@remote [in .git/config]
git remote rm ${REPO_REMOTE_NAME}
## Rename 1 repo@remote [in .git/config]
git remote rename ${REPO_REMOTE_NAME_OLD} ${REPO_REMOTE_NAME_NEW}

```


