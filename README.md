# Docker Haste
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/nicholaswilde/haste)](https://hub.docker.com/r/nicholaswilde/haste)
[![Docker Pulls](https://img.shields.io/docker/pulls/nicholaswilde/haste)](https://hub.docker.com/r/nicholaswilde/haste)
[![GitHub](https://img.shields.io/github/license/nicholaswilde/docker-haste)](./LICENSE)
[![ci](https://github.com/nicholaswilde/docker-haste/workflows/ci/badge.svg)](https://github.com/nicholaswilde/docker-haste/actions?query=workflow%3Aci)
[![lint](https://github.com/nicholaswilde/docker-haste/workflows/lint/badge.svg?branch=main)](https://github.com/nicholaswilde/docker-haste/actions?query=workflow%3Alint)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A multi-architecture docker image for [Haste](https://github.com/zneix/haste-server) pastebin.

## Requirements
- [buildx](https://docs.docker.com/engine/reference/commandline/buildx/)

## Usage
### docker-compose
```
---
version: "2.1"
services:
  haste:
    image: nicholaswilde/haste
    container_name: haste
    environment:
      - TZ=America/Los_Angeles #optional
      - PUID=1000   #optional
      - PGID=1000   #optional
    ports:
      - 7777:7777
    restart: unless-stopped
    volumes:
      - app:/app
volumes:
  app:
  config:
  defaults:
```
### docker cli
```bash
$ docker run -d \
  --name=haste \
  -e TZ=America/Los_Angeles `# optional` \
  -e PUID=1000  `# optional` \
  -e PGID=1000   `# optional` \
  -p 7777:7777 \
  --restart unless-stopped \
  nicholaswilde/haste
```

## Build

Check that you can build the following:
```bash
$ docker buildx ls
NAME/NODE    DRIVER/ENDPOINT             STATUS  PLATFORMS
mybuilder *  docker-container
  mybuilder0 unix:///var/run/docker.sock running linux/amd64, linux/arm64, linux/arm/v7
```

If you are having trouble building arm images on a x86 machine, see [this blog post](https://www.docker.com/blog/getting-started-with-docker-for-arm-on-linux/).

```
$ make build
```

## Pre-commit hook

If you want to automatically generate `README.md` files with a pre-commit hook, make sure you
[install the pre-commit binary](https://pre-commit.com/#install), and add a [.pre-commit-config.yaml file](./.pre-commit-config.yaml)
to your project. Then run:

```bash
pre-commit install
pre-commit install-hooks
```
Currently, this only works on `amd64` systems.

## License

[Apache 2.0 License](./LICENSE)

## Author
This project was started in 2021 by [Nicholas Wilde](https://github.com/nicholaswilde/).
