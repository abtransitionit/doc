[//]: #(Home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[cli whatis]:       ../whatis/cli.md

[←][home] 

Related topics
|||
|-|-|
|[what is cli][cli whatis]|see




<h1 align="center">rctl CLI</h1>



# Install
install or upgrade 
```
curl ... | sh
```

# Validate
```sh
# could run in CI on the metadata sourceof trust
rctl repogit doctor
```
could produce
```
Repository inventory
────────────────────────────
✓ 47 repositories found
✓ 47 documented
✓ 46 GitHub links valid
✓ 45 GitLab links valid
⚠ project-x missing template metadata
⚠ project-y has stale documentation

Templates
────────────────────────────
✓ go-lib       v1.4.0
✓ go-service   v2.1.0
⚠ shell-tool   v0.8.0 → v0.9.0 available
```
