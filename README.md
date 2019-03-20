[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)

# docker-buildbot-worker

This repository contains [buildbot-worker](https://buildbot.net/)
Docker images for the `x86_64` and `i386` architectures, for the
following platforms:

- [Centos 5](centos/5/Dockerfile.m4)
- [Debian 6](debian/6/Dockerfile.m4)
- [Ubuntu 16.04](ubuntu/16.04/Dockerfile.m4)

## Requirements

Building the Docker images requires the
[m4](https://www.gnu.org/software/m4/) preprocessor.

## Usage

| Target | Description |
| --- | --- |
| `make`<br>`make build` | Build the images. |
| `make push` | Upload the images to Docker Hub. |
| `make login` | Log into Docker Hub. |

Pass `REPO` to prefix the images with a Docker Hub repository name. If
`DOCKER_USERNAME` is set, `REPO` defaults to its value.

Pass `DIRS` to select individual images, e.g. `make DIRS=alpine/3.9.2`
to only build the image for Alpine 3.9.2.

The `login` target is provided for non-interactive use (CI) and looks
for `DOCKER_USERNAME` and `DOCKER_PASSWORD` in the environment.

