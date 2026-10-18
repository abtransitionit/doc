[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[Jelly github whatis]:       https://github.com/jellyfin/jellyfin
[ssg whatis]:       /concept/tool/whatis/ssg.md
[podman whatis]:    /tool/podamn/whatis/ep.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Jelly on Github][Jelly github whatis]|external|github
| [What is SSG][ssg whatis]|external|github
| [What is Podamn][podman whatis]|



<h1 align="center">What is Jelly</h1>


# Definition
- a [SSG][ssg whatis]


# Minimal site
To get a minimal `Jekyll` site up and running with a Jekyll container, 3 files at least are needed 
- `Gemfile`
- `_config.yml`
- `index.md`

**`Gemfile`**: Tells Jekyll which gem packages to use.

```ruby
source "https://rubygems.org"
gem "jekyll"
```
**`_config.yml`**: The basic configuration file for your site.

```yaml
title: My Static Site
description: Running Jekyll in a container on my VPS.
```

**`index.md`**: The homepage content.

```markdown
---
layout: default
title: Home
---

# Hello from Jekyll on my VPS!
This site is successfully running inside a container.
```

# Build an serve
Do
1. Instanciate server container from image as non-root user on HOST
1. Run the server (Inside the container)
1. Containe User UID/GID = non-root Host User UID/GID

```sh
# define var
CONT_IMAGE="docker.io/jekyll/jekyll"
HOST_FOLDER="${HOME}/wkspc/ssg/jekyll"
HTC_FOLDER="/srv/jekyll" # HostToContainer
MOUNT_OPTION="z"
HOST_PORT="4000"
CONT_PORT="4000"
CONT_NAME="mxc-jekyll-server"
CONT_CLI="jekyll serve --host 0.0.0.0"
VM_IP="omt.ovh"
# create the container

podman run -d --rm --userns=keep-id --name ${CONT_NAME} \
  -p ${HOST_PORT}:${CONT_PORT} \
  -v ${HOST_FOLDER}:${HTC_FOLDER}:${MOUNT_OPTION} \
     ${CONT_IMAGE} ${CONT_CLI}

echo "Jekyll server started! Access it at http://${VM_IP}:${HOST_PORT}"
```

# See the logs
```sh
podman logs -f ${CONT_NAME}
```

# stop and kill the container
```sh
podman stop ${CONT_NAME}.
```

Once those three files are sitting in your directory, run:

```bash
podman run --rm \
  --userns=keep-id \
  -p 4000:4000 \
  -v $(pwd):/srv/jekyll:z \
  jekyll/jekyll \
  jekyll serve --host 0.0.0.0


```


```  

# See the site:

Open the browser to `http://YOUR_VPS_IP:4000` and your site will be live!