[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[registry list]: ../list/registry.md
[hypervisor list]: ../list/hypervisor.md
[vm whatis]: ../list/registry.md
[container whatis]: ../whatis/vm.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of registries][registry list]|
|[List of hypervisor][hypervisor list]|

<h1 align="center">How-to for Container Image</h1>

The concept of Image

# pulling an image

```sh
# Docker Hub
docker pull nginx:latest

# GitHub Container Registry
docker pull ghcr.io/owner/image:tag

# GitLab Container Registry
docker pull registry.gitlab.com/group/project/image:tag

# Red Hat Quay
docker pull quay.io/organization/image:tag
```

# Build an image

## for diffrent CPU arch
```sh
# build and push
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t my-registry/my-app:latest \
  --push .
```  

## for the current CPU arch
```sh
# build
docker build -t my-app:latest .
```  

# Use case

```bash
# on a x86-64 - Intel/AMD PC - build locally a container image
docker build -t my-app:latest .
```
**Key point:** 
- The image is stamped as **`linux/amd64`**
- images are tied to the architecture they were built for.
- images are **CPU-specific**

```bash
# on the x86-64 - push the container image to registry
docker push my-app:latest
```
**Key point:** The registry doesn't care what CPU the image is for. It just stores bytes.

```bash
# on a arm64 - Mac M5 - pull the container image
docker pull my-app:latest
```
**Key point:** he image's platform tag is `linux/amd64` But your Mac is `linux/arm64`. **Mismatch.**


**Options:**
1. **Run it under emulation** (QEMU or Rosetta) — it works, but slower.
1. **Get a warning** that the platform doesn't match — and it may fail.
1. ✅ **Rebuild it natively** for arm64 if you want full speed.


## solution
- Build a **multi-arch image** image that works on both `x86-64` and `arm64`.

```bash
# build a multi arch images
docker buildx build --platform linux/amd64,linux/arm64 -t my-app:latest --push .
```
**Key point:** when a machine pulls `my-app:latest`, Docker automatically picks the CPU targeted version
