[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[aft whatis]: https://aft.dev/docs/
[aft git]:    https://github.com/akumansley/aft

Related topics

| Topic | Location | Kind    |
| - | - | - |
|[What is aft][aft whatis]|external| 
|[aft on github][aft git]|external| 

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is Podamn</h1>


# Definition
- A container management tool

# Howto

## Create ephemeral container
Do
1. Instanciate ephemeral CLI container from image as non-root user on HOST
1. Run CLI (Inside the container)
1. Display output (on HOST `stdout`)

```sh
# define var
CONT_IMAGE="alpine"
CONT_CLI="id" # display user identity inside the container
CONT_CLI="cat /etc/passwd" # interresting with and without --user 1000:1000
CONT_CLI="cat /etc/group"  # display user identity inside the container

# do
podman run --rm ${CONT_IMAGE} ${CONT_CLI}
podman run --rm --user 1000:1000 ${CONT_IMAGE} "${CONT_CLI}" # run container with UID/GID → 1000:1000
podman run --rm --userns=keep-id ${CONT_IMAGE} "${CONT_CLI}" # run container with HOST UID/GID
```

```sh
# Define variables
CONT_IMAGE="alpine"
CONT_CLI='
echo "###"
id
echo "###"
grep "^ubuntu:" /etc/passwd
echo "###"
grep "^1000:" /etc/group
'

podman run --rm --user 1000:1000 ${CONT_IMAGE} sh -c "${CONT_CLI}"
```

## Create a brief container
Do
1. Instanciate ephemeral CLI container from image as non-root user on HOST
1. Run CLI (Inside the container)
1. Display output (on HOST `stdout`)

```sh
# define var
CONT_IMAGE="alpine"
CONT_NAME="mxc-test"
CONT_CLI="sleep 300" # loop to stay alive

# create the container
CONT_SHA=$(podman run -d --name ${CONT_NAME} ${CONT_IMAGE} ${CONT_CLI})
9b7f86232a9ddeb1461076ed2921bf88b415d3eaf277c38e492658c7cc39e972

# get its PID on HOST
CONT_PID=$(podman inspect -f '{{.State.Pid}}' ${CONT_NAME})     # on host - 534512

# check the mapping
cat /proc/${CONT_PID}/uid_map
cat /proc/${CONT_PID}/gid_map
```
Meaning:
| Container UID | Parent namespace UID | Number of IDs | Explanation                                                                 |
| ------------- | -------------------- | ------------- | --------------------------------------------------------------------------- |
| `0`           | `1000`               | `1`           | Container UID 0 → HOST UDI 1000                                     |
| `1`           | `100000`             | `65,536`      | <li>Container UID 1 → HOST UDI 100000 <li>Container UID 2 → HOST UDI 100001<li>...<li>Container UID 65536 → HOST UDI 165537<li>                                     |


## Create a file on the HOST

create a file on the host 
- with HOST user identity
- using ephemeral container

Do
1. Instanciate ephemeral CLI container from image as non-root user on HOST
1. Mount Host:folder into Container:folder
1. Run CLI (Inside the container)
1. Display output (on HOST `stdout`)

```sh
# define var
CONT_IMAGE="alpine"
HOST_FOLDER="$HOME/wkspc/tmp"
HTC_FOLDER="/container_home"        # HostToContainer
FILE_NAME="test_container.txt"
HTC_FILE_PATH="${HTC_FOLDER}/${FILE_NAME}"
HOST_FILE_PATH="${HOST_FOLDER}/${FILE_NAME}"
CONT_CLI="touch ${HTC_FILE_PATH}"   

# do
podman run --rm -v ${HOST_FOLDER}:${HTC_FOLDER} ${CONT_IMAGE} ${CONT_CLI}
ls -ial ${HOST_FILE_PATH}
```