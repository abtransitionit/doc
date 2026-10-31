---
---
[//]: #(Reference)



# Install the cli on linux
**build the CLI for the platform**
```sh
lGOARCH="arm64"
lGOOS="darwin" # mac

# download the GO source code
git clone https://github.com/cli/cli.git gh-cli

# build the binary in the current folder
cd gh-cli
$ GOOS=darwin GOARCH=arm64 make clean bin/gh

# move the cli to /usr/local/bin
sudo cp bin/gh /usr/local/bin/
```


# Display the token
```
gh auth token
```

# Authenticate to Github
```
gh auth login
```
# Use `git` with `gh` for private repo
```sh
# configure cli `git` to use `gh` as a credential helper
gh auth setup-git

# do
git clone ...
```
Meaning:
- cli `git` gets credentials from `gh`

# Use `curl` with `gh` for private repo
```sh
# using envar
curl -H "Authorization: Bearer $GH_TOKEN" https://raw.githubusercontent.com/myorg/private-repo/main/file.sh

# using cli (gh)
curl -H "Authorization: Bearer $(gh auth token)" https://raw.githubusercontent.com/myorg/private-repo/main/file.sh
```
# Run any API

# Use the CLI `gh`
```shell
export GH_TOKEN="..."
```
# Using Github API in Github actions

## List recent workflow:runid**
```bash

# define var
lOWNER="abtransitionit"
lREPO="luc"

# do
gh run list -R ${lOWNER}/${lREPO}
```
output:
```
buntu@vps-9c33782a:~$ gh run list -R abtransitionit/luc
STATUS  TITLE         WORKFLOW  BRANCH  EVENT         ID           ELAPSED  AGE
X       Release       Release   main    workflow_run  15520696754  10s      about 16 hours ago
✓       Build         Build     main    workflow_run  15520690788  38s      about 16 hours ago
✓       Info          Info      main    workflow_run  15520690787  22s      about 16 hours ago
✓       Blind test    Tag       main    push          15520689751  9s       about 16 hours ago
X       Release       Release   main    workflow_run  15520600538  8s       about 16 hours ago
✓       Build         Build     main    workflow_run  15520595156  40s      about 16 hours ago
✓       Info          Info      main    workflow_run  15520595144  24s      about 16 hours ago
✓       try agian     Tag       main    push          15520593143  10s      about 16 hours ago
X       Release       Release   main    workflow_run  15520492942  7s       about 16 hours ago
✓       Build         Build     main    workflow_run  15520487554  36s      about 16 hours ago
✓       Info          Info      main    workflow_run  15520487549  23s      about 16 hours ago
✓       test it       Tag       main    push          15520487062  7s       about 16 hours ago
X       Release       Release   main    workflow_run  15520355211  9s       about 17 hours ago
✓       Build         Build     main    workflow_run  15520349286  40s      about 17 hours ago
✓       Info          Info      main    workflow_run  15520349280  22s      about 17 hours ago
✓       try Gh token  Tag       main    push          15520348034  9s       about 17 hours ago
X       Release       Release   main    workflow_run  15520337213  9s       about 17 hours ago
✓       Info          Info      main    workflow_run  15520332509  21s      about 17 hours ago
✓       Build         Build     main    workflow_run  15520332508  36s      about 17 hours ago
✓       add token     Tag       main    push          15520330190  12s      about 17 hours ago
```

## List artifacts of a workflow instance
```bash
lOWNER="abtransitionit"
lREPO="luc"
lRUNID="15520690788"
gh api "/repos/${lOWNER}/${lREPO}/actions/runs/${lRUNID}/artifacts"
gh api "/repos/${lOWNER}/${lREPO}/actions/runs/${lRUNID}/artifacts" | jq '.artifacts[] | {name, id, size_in_bytes, expired}'
```



- it is possible for lot of use case to avoid complex API cal with the cli `gh` (aka. **G**it**h**ub CLI)
```bash
# WORKFLOW_INSTANCE_ID often called RUN_ID
# -WORKFLOW_INSTANCE_ID: ${{ github.event.workflow_run.id }}
gh run view ${{ WORKFLOW_INSTANCE_ID }} --json artifacts --jq '.artifacts[].name'
```

## Delete workflow runs and finally the worflow
```shell
# define var
lWORKFLOW_FNAME="ci-dev.yaml"
lOWNER="abtransitionit"
lREPO="gocore"

# git clone the repo
# cd the repo
# play the CLI
gh run list -R ${lOWNER}/${lREPO} --limit 40 --workflow ${lWORKFLOW_FNAME} --json databaseId -q ".[].databaseId" | xargs -I {} gh run delete {} -R ${lOWNER}/${lREPO}
gh run list -R ${lOWNER}/${lREPO}  --workflow ${lWORKFLOW_FNAME} --json databaseId -q ".[].databaseId" | xargs -I {} gh run delete {} -R ${lOWNER}/${lREPO}
```

# Test
```bash
gh run view ${{ WORKFLOW_INSTANCE_ID }} --json artifacts --jq '.artifacts[].name'
```

```bash
gh run view ${{ WORKFLOW_INSTANCE_ID }} --json artifacts --jq '.artifacts[].name'
gh run artifacts --run-id ${{ WORKFLOW_INSTANCE_ID }}
```
# Get info
```sh
# static
git -C "$lPRJ_NAME" remote add origin https://github.com/abtransitionit/${lPRJ_NAME}.git
# dynamic
git -C "$lPRJ_NAME" remote add origin "$(gh repo view "$lPRJ_NAME" --json url --jq '.url')" 
```

# Display info
```sh
# users and organization
gh api users/abtransitionit
gh api orgs/abtransitionit
❌ gh api orgs/abelgacem 
gh api users/abelgacem
gh api user/memberships/orgs/abtransitionit
```
```
GitHub
│
├── User account
│   └── abelgacem
│
│       └── direct member of
│             │
│             ▼
│       Organization
│       └── abtransitionit
│
└── ...
```

# Todo
```sh
gh api repos/myorg/myrepo

# in CI use the token that exists in the env
GH_TOKEN="$MY_TOKEN" gh api repos/myorg/myrepo

# run: gh run view
# run: gh run download <run-id> --dir /tmp/ 

# run: gh run view ${{ github.run_id }} --json artifacts --jq '.artifacts[].name'
# run: gh run artifacts --run-id ${{ steps.get_wf_instance_info.outputs.WORKFLOW_INSTANCE_ID }}

```


