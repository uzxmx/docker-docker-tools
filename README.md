# Docker image for docker

[![Build Status](https://travis-ci.org/uzxmx/docker-docker-tools.svg?branch=master)](https://travis-ci.org/uzxmx/docker-docker-tools)

This docker image is based on [the official docker image](https://hub.docker.com/_/docker), and
adds other useful tools for building, currently include:

* git
* make
* aws-cli

## Development

For developers in China, when it's slow to download alpine packages, you can use
a mirror e.g. `mirrors.tuna.tsinghua.edu.cn`.

```
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
  && apk add --no-cache ... \
  && ... \
  && apk del ...
```
