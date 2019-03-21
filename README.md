[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)

# docker-buildbot-worker

This repository contains Docker images for
[buildbot worker](https://buildbot.net/), for the following platforms
and architectures:

| Platform | Dockerfile (by arch) |
| --- | :---: |
| Alpine 3.9.2 | [`x86_64`](alpine/3.9.2/Dockerfile.x86_64) [`i386`](alpine/3.9.2/Dockerfile.i386) |
| Centos 5 | [`x86_64`](centos/5/Dockerfile.x86_64) [`i386`](centos/5/Dockerfile.i386) |
| Centos 7 | [`x86_64`](centos/7/Dockerfile.x86_64) |
| Debian 6 (squeeze) | [`x86_64`](debian/6/Dockerfile.x86_64) [`i386`](debian/6/Dockerfile.i386) |
| Debian 9 (stretch) | [`x86_64`](debian/9/Dockerfile.x86_64) [`i386`](debian/9/Dockerfile.i386) |
| Ubuntu 16.04 (xenial) | [`x86_64`](ubuntu/16.04/Dockerfile.x86_64) [`i386`](ubuntu/16.04/Dockerfile.i386) |

This project has a [changelog](CHANGELOG.md).

## Requirements

Generating the Dockerfiles requires the
[m4](https://www.gnu.org/software/m4/) preprocessor.

## Usage

| Target | Description |
| --- | --- |
| `make prepare` | Generate the Dockerfiles. |
| `make build` | Build the images. |
| `make push` | Upload the images to Docker Hub. |
| `make login` | Log into Docker Hub. |

Pass `REPO` to prefix the images with a Docker Hub repository name. The
default is `DOCKER_USERNAME`.

Pass `DIRS` to select individual images, e.g. `make DIRS=alpine/3.9.2`
to only build the image for Alpine 3.9.2.

The `login` target is provided for non-interactive use and looks
for `DOCKER_USERNAME` and `DOCKER_PASSWORD`.
