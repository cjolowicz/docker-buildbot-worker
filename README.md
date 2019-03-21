[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)

# docker-buildbot-worker

This repository contains Docker images for
[buildbot worker](https://buildbot.net/), for the following platforms
and architectures:

| Platform | Dockerfile (by arch) |
| --- | :---: |
| Alpine 3.9 | [`x86_64`](alpine/3.9/x86_64/Dockerfile) [`i386`](alpine/3.9/i386/Dockerfile) |
| Centos 5 | [`x86_64`](centos/5/x86_64/Dockerfile) [`i386`](centos/5/i386/Dockerfile) |
| Centos 7 | [`x86_64`](centos/7/x86_64/Dockerfile) |
| Debian 6 (squeeze) | [`x86_64`](debian/6/x86_64/Dockerfile) [`i386`](debian/6/i386/Dockerfile) |
| Debian 7 (wheezy) | [`x86_64`](debian/7/x86_64/Dockerfile) [`i386`](debian/7/i386/Dockerfile) |
| Debian 8 (jessie) | [`x86_64`](debian/8/x86_64/Dockerfile) [`i386`](debian/8/i386/Dockerfile) |
| Debian 9 (stretch) | [`x86_64`](debian/9/x86_64/Dockerfile) [`i386`](debian/9/i386/Dockerfile) |
| Ubuntu 16.04 (xenial) | [`x86_64`](ubuntu/16.04/x86_64/Dockerfile) [`i386`](ubuntu/16.04/i386/Dockerfile) |
| Ubuntu 18.04 (bionic) | [`x86_64`](ubuntu/18.04/x86_64/Dockerfile) [`i386`](ubuntu/18.04/i386/Dockerfile) |

This project has a [changelog](CHANGELOG.md).

## Requirements

Generating the Dockerfiles requires the
[m4](https://www.gnu.org/software/m4/) preprocessor.

## Usage

| Target | Description |
| --- | --- |
| `make build` | Build the images. |
| `make push` | Upload the images to Docker Hub. |
| `make login` | Log into Docker Hub. |
| `make dep` | Generate the dependency rules. |
| `make prepare` | Generate the Dockerfiles. |

Pass `REPO` to prefix the images with a Docker Hub repository name. The
default is `DOCKER_USERNAME`.

Pass `DIRS` to select individual images, e.g. `make DIRS=alpine/3.9`
to only build the image for Alpine 3.9.

The `login` target is provided for non-interactive use and looks
for `DOCKER_USERNAME` and `DOCKER_PASSWORD`.
