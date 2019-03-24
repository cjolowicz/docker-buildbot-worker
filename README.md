[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)
[![Docker Hub](https://img.shields.io/docker/cloud/build/cjolowicz/buildbot-worker.svg)](https://hub.docker.com/r/cjolowicz/buildbot-worker)
[![Buildbot](https://img.shields.io/badge/buildbot-1.8.0-brightgreen.svg)](https://buildbot.net/)

# docker-buildbot-worker

This repository contains Docker images for
[buildbot worker](https://buildbot.net/), for the following platforms
and architectures:

| Platform | Dockerfile (by arch) |
| --- | --- |
| Alpine 3.9 | [`x86_64`](alpine/3.9/x86_64/Dockerfile) [`i386`](alpine/3.9/i386/Dockerfile) |
| Centos 5 | [`x86_64`](centos/5/x86_64/Dockerfile) [`i386`](centos/5/i386/Dockerfile) |
| Centos 7 | [`x86_64`](centos/7/x86_64/Dockerfile) |
| Debian 5 (lenny) | [`x86_64`](debian/5/x86_64/Dockerfile) [`i386`](debian/5/i386/Dockerfile) |
| Debian 6 (squeeze) | [`x86_64`](debian/6/x86_64/Dockerfile) [`i386`](debian/6/i386/Dockerfile) |
| Debian 7 (wheezy) | [`x86_64`](debian/7/x86_64/Dockerfile) [`i386`](debian/7/i386/Dockerfile) |
| Debian 8 (jessie) | [`x86_64`](debian/8/x86_64/Dockerfile) [`i386`](debian/8/i386/Dockerfile) |
| Debian 9 (stretch) | [`x86_64`](debian/9/x86_64/Dockerfile) [`i386`](debian/9/i386/Dockerfile) |
| OpenSUSE 42 | [`x86_64`](opensuse/42/x86_64/Dockerfile) |
| Scientific 7 | [`x86_64`](scientific/7/x86_64/Dockerfile) |
| Ubuntu 12.04 (precise) | [`x86_64`](ubuntu/12.04/x86_64/Dockerfile) [`i386`](ubuntu/12.04/i386/Dockerfile) |
| Ubuntu 14.04 (trusty) | [`x86_64`](ubuntu/14.04/x86_64/Dockerfile) [`i386`](ubuntu/14.04/i386/Dockerfile) |
| Ubuntu 16.04 (xenial) | [`x86_64`](ubuntu/16.04/x86_64/Dockerfile) [`i386`](ubuntu/16.04/i386/Dockerfile) |
| Ubuntu 18.04 (bionic) | [`x86_64`](ubuntu/18.04/x86_64/Dockerfile) [`i386`](ubuntu/18.04/i386/Dockerfile) |

The Docker images are loosely based on the
[official image](https://github.com/buildbot/buildbot/tree/master/worker).

This project has a [changelog](CHANGELOG.md).

## Usage

There are two primary ways to run these images in a buildbot
installation:

- as long-running containers
- on demand, using [`DockerLatentWorker`](http://docs.buildbot.net/current/manual/configuration/workers-docker.html)

Containers can be configured using the following environment
variables:

| Variable | Description |
| --- | --- |
| `BUILDMASTER` | the domain name or IP address of the master to connect to |
| `BUILDMASTER_PORT` | the port of the worker protocol |
| `WORKERNAME` | the name of the worker as declared in the master configuration |
| `WORKERPASS` | the password of the worker as declared in the master configuration |
| `WORKER_ENVIRONMENT_BLACKLIST` | the worker environment variables to remove before starting the worker |

As the environment variables are accessible from the build, and
displayed in the log, it is better to remove secret variables like
`WORKERPASS`.

It is important to ensure that any zombie processes created by builds
will be reaped during the lifetime of the container. Unlike the
official image, these images don't use
[dumb-init](https://github.com/Yelp/dumb-init) as PID 1. Modern
versions of Docker ship with [tini](https://github.com/krallin/tini),
which provides the same functionality. However, this means that you
need to specify the `--init` option when invoking `docker run`. This
will install `tini` as the entrypoint for the container.

## Building

Generating the Dockerfiles requires
[GNU make](https://www.gnu.org/software/make/) and the
[GNU m4](https://www.gnu.org/software/m4/) preprocessor.

Here is a list of available targets:

| Target | Description |
| --- | --- |
| `make build` | Build the images. |
| `make push` | Upload the images to Docker Hub. |
| `make login` | Log into Docker Hub. |
| `make dep` | Generate the dependency rules. |
| `make prepare` | Generate the Dockerfiles. |

Pass `REPO` to prefix the images with a Docker Hub repository name. The
default is `DOCKER_USERNAME`.

Pass `DIRS` to select individual images, e.g. `make
DIRS=alpine/3.9/x86_64` to only build the 64-bit image for Alpine 3.9.

The `login` target is provided for non-interactive use and looks
for `DOCKER_USERNAME` and `DOCKER_PASSWORD`.
