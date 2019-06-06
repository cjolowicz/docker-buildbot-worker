[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)
[![Docker Hub](https://img.shields.io/docker/cloud/build/cjolowicz/buildbot-worker.svg)](https://hub.docker.com/r/cjolowicz/buildbot-worker)
[![Buildbot](https://img.shields.io/badge/buildbot-2.3.1-brightgreen.svg)](https://buildbot.net/)

# docker-buildbot-worker

This repository contains Docker images for [buildbot
worker](https://buildbot.net/), for the following platforms and architectures:

| Platform               | Dockerfile (by arch)                                                              |
| ---                    | ---                                                                               |
| Alpine 3.9             | [`x86_64`](alpine/3.9/x86_64/Dockerfile) [`i386`](alpine/3.9/i386/Dockerfile)     |
| CentOS 5               | [`x86_64`](centos/5/x86_64/Dockerfile) [`i386`](centos/5/i386/Dockerfile)         |
| CentOS 6               | [`x86_64`](centos/6/x86_64/Dockerfile) [`i386`](centos/6/i386/Dockerfile)         |
| CentOS 7               | [`x86_64`](centos/7/x86_64/Dockerfile)                                            |
| Debian 5 (lenny)       | [`x86_64`](debian/5/x86_64/Dockerfile)                                            |
| Debian 6 (squeeze)     | [`x86_64`](debian/6/x86_64/Dockerfile) [`i386`](debian/6/i386/Dockerfile)         |
| Debian 7 (wheezy)      | [`x86_64`](debian/7/x86_64/Dockerfile) [`i386`](debian/7/i386/Dockerfile)         |
| Debian 8 (jessie)      | [`x86_64`](debian/8/x86_64/Dockerfile) [`i386`](debian/8/i386/Dockerfile)         |
| Debian 9 (stretch)     | [`x86_64`](debian/9/x86_64/Dockerfile) [`i386`](debian/9/i386/Dockerfile)         |
| OpenSUSE 13            | [`x86_64`](opensuse/13/x86_64/Dockerfile)                                         |
| OpenSUSE 42            | [`x86_64`](opensuse/42/x86_64/Dockerfile)                                         |
| OpenSUSE 15            | [`x86_64`](opensuse/15/x86_64/Dockerfile)                                         |
| Scientific 6           | [`x86_64`](scientific/6/x86_64/Dockerfile)                                        |
| Scientific 7           | [`x86_64`](scientific/7/x86_64/Dockerfile)                                        |
| Ubuntu 12.04 (precise) | [`x86_64`](ubuntu/12.04/x86_64/Dockerfile) [`i386`](ubuntu/12.04/i386/Dockerfile) |
| Ubuntu 14.04 (trusty)  | [`x86_64`](ubuntu/14.04/x86_64/Dockerfile) [`i386`](ubuntu/14.04/i386/Dockerfile) |
| Ubuntu 16.04 (xenial)  | [`x86_64`](ubuntu/16.04/x86_64/Dockerfile) [`i386`](ubuntu/16.04/i386/Dockerfile) |
| Ubuntu 18.04 (bionic)  | [`x86_64`](ubuntu/18.04/x86_64/Dockerfile) [`i386`](ubuntu/18.04/i386/Dockerfile) |

The Docker images are loosely based on the [official
image](https://github.com/buildbot/buildbot/tree/master/worker).

This project has a [changelog](CHANGELOG.md).

## Usage

There are two primary ways to run these images in a buildbot installation:

- as long-running containers
- on demand, using
  [`DockerLatentWorker`](http://docs.buildbot.net/current/manual/configuration/workers-docker.html)
  or
  [`DockerSwarmLatentWorker`](https://github.com/cjolowicz/buildbot-docker-swarm-worker)

Containers can be configured using the following environment variables:

| Variable                       | Description                                                           |
| ---                            | ---                                                                   |
| `BUILDMASTER`                  | the domain name or IP address of the master to connect to             |
| `BUILDMASTER_PORT`             | the port of the worker protocol                                       |
| `WORKERNAME`                   | the name of the worker as declared in the master configuration        |
| `WORKERPASS`                   | the password of the worker as declared in the master configuration    |
| `WORKER_ENVIRONMENT_BLACKLIST` | the worker environment variables to remove before starting the worker |

As the environment variables are accessible from the build, and displayed in the
log, it is better to remove secret variables like `WORKERPASS`.

It is important to ensure that any zombie processes created by builds will be
reaped during the lifetime of the container. Unlike the official image, these
images don't use [dumb-init](https://github.com/Yelp/dumb-init) as PID 1. Modern
versions of Docker ship with [tini](https://github.com/krallin/tini), which
provides the same functionality. However, this means that you need to specify
the `--init` option when invoking `docker run`. This will install `tini` as the
entrypoint for the container.

## Tags

The full tag has the form `VERSION-PLATFORM-RELEASE-ARCH`.

`VERSION` consists of the upstream version and a single-component 1-based
downstream version, e.g. _2.0.0-1_.

Abbreviated tags are provided with `VERSION` replaced by the upstream version
and each of its prefixes, e.g. _2.0.0_, _2.0_, _2_. These abbreviated tags have
the following forms:

- `VERSION-PLATFORM-RELEASE-ARCH`
- `VERSION-PLATFORM-RELEASE`, for the default architecture (`x86_64`)
- `VERSION-PLATFORM`, for the default architecture (`x86_64`) and the latest
   supported release of that platform
- `VERSION`, for the default architecture (`x86_64`) and the latest supported
   Alpine release
- `latest`, for the default architecture (`x86_64`) and the latest supported
   Alpine release

Here are some examples:

| Image                                   | Buildbot     | Platform       | Architecture |
| ---                                     | ---          | ---            | ---          |
| cjolowicz/buildbot-worker               | latest       | current Alpine | `x86_64`     |
| cjolowicz/buildbot-worker:2-debian      | latest 2.x   | current Debian | `x86_64`     |
| cjolowicz/buildbot-worker:2-debian-7    | latest 2.x   | Debian 7       | `x86_64`     |
| cjolowicz/buildbot-worker:1.8           | latest 1.8.x | current Alpine | `x86_64`     |
| cjolowicz/buildbot-worker:1-centos-i386 | latest 1.x   | current CentOS | `i386`       |

## Building

Generating the Dockerfiles requires [GNU
make](https://www.gnu.org/software/make/) and the [GNU
m4](https://www.gnu.org/software/m4/) preprocessor.

Here is a list of available targets:

| Target         | Description                      |
| ---            | ---                              |
| `make build`   | Build the images.                |
| `make push`    | Upload the images to Docker Hub. |
| `make login`   | Log into Docker Hub.             |
| `make dep`     | Generate the dependency rules.   |
| `make prepare` | Generate the Dockerfiles.        |

Pass `NAMESPACE` to prefix the images with a Docker Hub repository name. The
default is `DOCKER_USERNAME`.

Pass `DIRS` to select individual images, e.g. `make DIRS=alpine/3.9/x86_64` to
only build the 64-bit image for Alpine 3.9.

The `login` target is provided for non-interactive use and looks for
`DOCKER_USERNAME` and `DOCKER_PASSWORD`.

## Related projects

- https://github.com/cjolowicz/docker-buildbot
- https://github.com/cjolowicz/buildbot-docker-swarm-worker
