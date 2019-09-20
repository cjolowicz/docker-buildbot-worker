[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)
[![Docker Hub](https://img.shields.io/docker/cloud/build/cjolowicz/buildbot-worker.svg)](https://hub.docker.com/r/cjolowicz/buildbot-worker)
[![Buildbot](https://img.shields.io/badge/buildbot-2.4.1-brightgreen.svg)](https://buildbot.net/)

# docker-buildbot-worker

This repository contains an inofficial [Docker](https://www.docker.com/) image
for Buildbot Worker. 

Buildbot Worker is the software that runs build jobs for
[buildbot](https://buildbot.net/), the Continuous Integration framework.

## Supported tags and respective `Dockerfile` links

- [`2.4.1`, `2.4`, `2`, `latest`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/alpine/3.10/x86_64/Dockerfile)
- [`2.4.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/alpine/3.9/x86_64/Dockerfile)
- [`2.3.1`, `2.3`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/alpine/3.9/x86_64/Dockerfile)
- [`2.3.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/alpine/3.9/x86_64/Dockerfile)
- [`2.2.0`, `2.2`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/alpine/3.9/x86_64/Dockerfile)
- [`2.1.0`, `2.1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/alpine/3.9/x86_64/Dockerfile)
- [`2.0.1`, `2.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/alpine/3.9/x86_64/Dockerfile)
- [`2.0.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/alpine/3.9/x86_64/Dockerfile)
- [`1.8.2`, `1.8`, `1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/alpine/3.9/x86_64/Dockerfile)
- [`1.8.1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/alpine/3.9/x86_64/Dockerfile)
- [`1.8.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/alpine/3.9/x86_64/Dockerfile)

## Quick reference

- **Where to file issues**:<br/>
  https://github.com/cjolowicz/docker-buildbot-worker/issues
- **Maintained by**:<br/>
  [Claudio Jolowicz](https://github.com/cjolowicz)
- **Supported architectures**:<br/>
  [`x86_64`](#x86_64-architecture), [`i386`](#i386-architecture)
- **Supported Docker versions**:<br/>
  [the latest release](https://github.com/docker/docker-ce/releases/latest)
- **Changelog**:<br/>
  https://github.com/cjolowicz/docker-buildbot-worker/blob/master/CHANGELOG.md

## What is buildbot?

Buildbot is an open-source framework for automating software build, test, and
release processes. Buildbot can automate all aspects of the software development
cycle: Continuous Integration, Continuous Deployment, Release Management, and
any other process you can imagine. Buildbot is a framework in which you
implement a system that matches your workflow and grows with your organization.

[![Buildbot Logo](https://raw.githubusercontent.com/buildbot/buildbot-media/master/images/full_logo.png)](https://buildbot.net/)

## How to use this image

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

## Image Variants

The `cjolowicz/buildbot-worker` images are available for a range of platforms,
and two architectures:

| `x86_64`                                                                                                     | `i386`                                                                                                                   |
| ---                                                                                                          | ---                                                                                                                      |
| [Alpine 3.10](#alpine-310) · [3.9](#alpine-39)                                                               | [Alpine 3.10](#alpine-310-i386) · [3.9](#alpine-39-i386)                                                                 |
| [CentOS 7](#centos-7) · [6](#centos-6) · [5](#centos-5)                                                      | [CentOS 6](#centos-6-i386) · [5](#centos-5-i386)                                                                         |
| [Debian 10](#debian-10) · [9](#debian-9) · [8](#debian-8) · [7](#debian-7) · [6](#debian-6) · [5](#debian-5) | [Debian 10](#debian-10-i386) · [9](#debian-9-i386) · [8](#debian-8-i386) · [7](#debian-7-i386) · [6](#debian-6-i386)     |
| [OpenSUSE 15](#opensuse-15) · [42](#opensuse-42) · [13](#opensuse-13)                                        |                                                                                                                          |
| [Scientific Linux 7](#scientific-linux-7) · [6](#scientific-linux-6)                                         |                                                                                                                          |
| [Ubuntu 18.04](#ubuntu-1804) · [16.04](#ubuntu-1604) · [14.04](#ubuntu-1404) · [12.04](#ubuntu-1204)         | [Ubuntu 18.04](#ubuntu-1804-i386) · [16.04](#ubuntu-1604-i386) · [14.04](#ubuntu-1404-i386) · [12.04](#ubuntu-1204-i386) |
 
### `cjolowicz/buildbot-worker:<version>`

This is the default image. This image uses the latest supported Alpine release
on the default architecture (`x86_64`).

`<version>` consists of the upstream version and a single-component 1-based
downstream version. Abbreviated tags are provided with `<version>` replaced by
the upstream version and each of its prefixes.

### `cjolowicz/buildbot-worker:<version>-<platform>`

These tags reference images for the latest supported release of the selected
platform. Currently, these are the following:

- [`cjolowicz/buildbot-worker:<version>-alpine`](#alpine-310) (Alpine 3.10)
- [`cjolowicz/buildbot-worker:<version>-centos`](#centos-7) (CentOS 7)
- [`cjolowicz/buildbot-worker:<version>-debian`](#debian-10) (Debian 10)
- [`cjolowicz/buildbot-worker:<version>-opensuse`](#opensuse-15) (OpenSUSE 15)
- [`cjolowicz/buildbot-worker:<version>-scientific`](#scientific-linux-7) (Scientific Linux 7)
- [`cjolowicz/buildbot-worker:<version>-ubuntu`](#ubuntu-1804) (Ubuntu 18.04)

### `cjolowicz/buildbot-worker:<version>-<platform>-<release>`

These tags reference images for the selected platform release.

Here are some examples:

- [`cjolowicz/buildbot-worker:<version>-debian-8`](#debian-8)
- [`cjolowicz/buildbot-worker:<version>-ubuntu-16.04`](#ubuntu-1604)

### `cjolowicz/buildbot-worker:<version>-<platform>-<release>-<architecture>`

The full tag includes the buildbot version, the platform release, as well as the
architecture.

## License

View [license information](https://github.com/buildbot/buildbot/blob/master/LICENSE) for Buildbot.

View [license information](https://github.com/cjolowicz/docker-buildbot-worker/blob/master/LICENSE.md) for `docker-buildbot-worker`.

As with all Docker images, these likely also contain other software which may be
under other licenses (such as Bash, etc from the base distribution, along with
any direct or indirect dependencies of the primary software being contained).

## List of all available images

- [x86_64 architecture](#x86_64-architecture)
- [i386 architecture](#i386-architecture)

### x86_64 architecture

Supported platforms:

- [Alpine 3.10](#alpine-310) · [3.9](#alpine-39)
- [CentOS 7](#centos-7) · [6](#centos-6) · [5](#centos-5)
- [Debian 10](#debian-10) · [9](#debian-9) · [8](#debian-8) · [7](#debian-7) · [6](#debian-6) · [5](#debian-5)
- [OpenSUSE 15](#opensuse-15) · [42](#opensuse-42) · [13](#opensuse-13)
- [Scientific Linux 7](#scientific-linux-7) · [6](#scientific-linux-6)
- [Ubuntu 18.04](#ubuntu-1804) · [16.04](#ubuntu-1604) · [14.04](#ubuntu-1404) · [12.04](#ubuntu-1204)

#### Alpine 3.10

- [`2.4.1-alpine-3.10-x86_64`, `2.4.1-alpine-3.10`, `2.4.1-alpine`, `2.4.1`, `2.4-alpine-3.10-x86_64`, `2.4-alpine-3.10`, `2.4-alpine`, `2.4`, `2-alpine-3.10-x86_64`, `2-alpine-3.10`, `2-alpine`, `2`, `latest`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/alpine/3.10/x86_64/Dockerfile)

#### Alpine 3.9

- [`2.4.1-alpine-3.9-x86_64`, `2.4.1-alpine-3.9`, `2.4-alpine-3.9-x86_64`, `2.4-alpine-3.9`, `2-alpine-3.9-x86_64`, `2-alpine-3.9`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/alpine/3.9/x86_64/Dockerfile)
- [`2.4.0-alpine-3.9-x86_64`, `2.4.0-alpine-3.9`, `2.4.0-alpine`, `2.4.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/alpine/3.9/x86_64/Dockerfile)
- [`2.3.1-alpine-3.9-x86_64`, `2.3.1-alpine-3.9`, `2.3.1-alpine`, `2.3.1`, `2.3-alpine-3.9-x86_64`, `2.3-alpine-3.9`, `2.3-alpine`, `2.3`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/alpine/3.9/x86_64/Dockerfile)
- [`2.3.0-alpine-3.9-x86_64`, `2.3.0-alpine-3.9`, `2.3.0-alpine`, `2.3.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/alpine/3.9/x86_64/Dockerfile)
- [`2.2.0-alpine-3.9-x86_64`, `2.2.0-alpine-3.9`, `2.2.0-alpine`, `2.2.0`, `2.2-alpine-3.9-x86_64`, `2.2-alpine-3.9`, `2.2-alpine`, `2.2`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/alpine/3.9/x86_64/Dockerfile)
- [`2.1.0-alpine-3.9-x86_64`, `2.1.0-alpine-3.9`, `2.1.0-alpine`, `2.1.0`, `2.1-alpine-3.9-x86_64`, `2.1-alpine-3.9`, `2.1-alpine`, `2.1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/alpine/3.9/x86_64/Dockerfile)
- [`2.0.1-alpine-3.9-x86_64`, `2.0.1-alpine-3.9`, `2.0.1-alpine`, `2.0.1`, `2.0-alpine-3.9-x86_64`, `2.0-alpine-3.9`, `2.0-alpine`, `2.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/alpine/3.9/x86_64/Dockerfile)
- [`2.0.0-alpine-3.9-x86_64`, `2.0.0-alpine-3.9`, `2.0.0-alpine`, `2.0.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/alpine/3.9/x86_64/Dockerfile)
- [`1.8.2-alpine-3.9-x86_64`, `1.8.2-alpine-3.9`, `1.8.2-alpine`, `1.8.2`, `1.8-alpine-3.9-x86_64`, `1.8-alpine-3.9`, `1.8-alpine`, `1.8`, `1-alpine-3.9-x86_64`, `1-alpine-3.9`, `1-alpine`, `1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/alpine/3.9/x86_64/Dockerfile)
- [`1.8.1-alpine-3.9-x86_64`, `1.8.1-alpine-3.9`, `1.8.1-alpine`, `1.8.1`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/alpine/3.9/x86_64/Dockerfile)
- [`1.8.0-alpine-3.9-x86_64`, `1.8.0-alpine-3.9`, `1.8.0-alpine`, `1.8.0`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/alpine/3.9/x86_64/Dockerfile)

#### CentOS 7

- [`2.4.1-centos-7-x86_64`, `2.4.1-centos-7`, `2.4.1-centos`, `2.4-centos-7-x86_64`, `2.4-centos-7`, `2.4-centos`, `2-centos-7-x86_64`, `2-centos-7`, `2-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/centos/7/x86_64/Dockerfile)
- [`2.4.0-centos-7-x86_64`, `2.4.0-centos-7`, `2.4.0-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/centos/7/x86_64/Dockerfile)
- [`2.3.1-centos-7-x86_64`, `2.3.1-centos-7`, `2.3.1-centos`, `2.3-centos-7-x86_64`, `2.3-centos-7`, `2.3-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/centos/7/x86_64/Dockerfile)
- [`2.3.0-centos-7-x86_64`, `2.3.0-centos-7`, `2.3.0-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/centos/7/x86_64/Dockerfile)
- [`2.2.0-centos-7-x86_64`, `2.2.0-centos-7`, `2.2.0-centos`, `2.2-centos-7-x86_64`, `2.2-centos-7`, `2.2-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/centos/7/x86_64/Dockerfile)
- [`2.1.0-centos-7-x86_64`, `2.1.0-centos-7`, `2.1.0-centos`, `2.1-centos-7-x86_64`, `2.1-centos-7`, `2.1-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/centos/7/x86_64/Dockerfile)
- [`2.0.1-centos-7-x86_64`, `2.0.1-centos-7`, `2.0.1-centos`, `2.0-centos-7-x86_64`, `2.0-centos-7`, `2.0-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/centos/7/x86_64/Dockerfile)
- [`2.0.0-centos-7-x86_64`, `2.0.0-centos-7`, `2.0.0-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/centos/7/x86_64/Dockerfile)
- [`1.8.2-centos-7-x86_64`, `1.8.2-centos-7`, `1.8.2-centos`, `1.8-centos-7-x86_64`, `1.8-centos-7`, `1.8-centos`, `1-centos-7-x86_64`, `1-centos-7`, `1-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/centos/7/x86_64/Dockerfile)
- [`1.8.1-centos-7-x86_64`, `1.8.1-centos-7`, `1.8.1-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/centos/7/x86_64/Dockerfile)
- [`1.8.0-centos-7-x86_64`, `1.8.0-centos-7`, `1.8.0-centos`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/centos/7/x86_64/Dockerfile)

#### CentOS 6

- [`2.4.1-centos-6-x86_64`, `2.4.1-centos-6`, `2.4-centos-6-x86_64`, `2.4-centos-6`, `2-centos-6-x86_64`, `2-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/centos/6/x86_64/Dockerfile)
- [`2.4.0-centos-6-x86_64`, `2.4.0-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/centos/6/x86_64/Dockerfile)
- [`2.3.1-centos-6-x86_64`, `2.3.1-centos-6`, `2.3-centos-6-x86_64`, `2.3-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/centos/6/x86_64/Dockerfile)
- [`2.3.0-centos-6-x86_64`, `2.3.0-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/centos/6/x86_64/Dockerfile)
- [`2.2.0-centos-6-x86_64`, `2.2.0-centos-6`, `2.2-centos-6-x86_64`, `2.2-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/centos/6/x86_64/Dockerfile)
- [`2.1.0-centos-6-x86_64`, `2.1.0-centos-6`, `2.1-centos-6-x86_64`, `2.1-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/centos/6/x86_64/Dockerfile)
- [`2.0.1-centos-6-x86_64`, `2.0.1-centos-6`, `2.0-centos-6-x86_64`, `2.0-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/centos/6/x86_64/Dockerfile)
- [`2.0.0-centos-6-x86_64`, `2.0.0-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/centos/6/x86_64/Dockerfile)
- [`1.8.2-centos-6-x86_64`, `1.8.2-centos-6`, `1.8-centos-6-x86_64`, `1.8-centos-6`, `1-centos-6-x86_64`, `1-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/centos/6/x86_64/Dockerfile)
- [`1.8.1-centos-6-x86_64`, `1.8.1-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/centos/6/x86_64/Dockerfile)
- [`1.8.0-centos-6-x86_64`, `1.8.0-centos-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/centos/6/x86_64/Dockerfile)

#### CentOS 5

- [`2.4.1-centos-5-x86_64`, `2.4.1-centos-5`, `2.4-centos-5-x86_64`, `2.4-centos-5`, `2-centos-5-x86_64`, `2-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/centos/5/x86_64/Dockerfile)
- [`2.4.0-centos-5-x86_64`, `2.4.0-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/centos/5/x86_64/Dockerfile)
- [`2.3.1-centos-5-x86_64`, `2.3.1-centos-5`, `2.3-centos-5-x86_64`, `2.3-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/centos/5/x86_64/Dockerfile)
- [`2.3.0-centos-5-x86_64`, `2.3.0-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/centos/5/x86_64/Dockerfile)
- [`2.2.0-centos-5-x86_64`, `2.2.0-centos-5`, `2.2-centos-5-x86_64`, `2.2-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/centos/5/x86_64/Dockerfile)
- [`2.1.0-centos-5-x86_64`, `2.1.0-centos-5`, `2.1-centos-5-x86_64`, `2.1-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/centos/5/x86_64/Dockerfile)
- [`2.0.1-centos-5-x86_64`, `2.0.1-centos-5`, `2.0-centos-5-x86_64`, `2.0-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/centos/5/x86_64/Dockerfile)
- [`2.0.0-centos-5-x86_64`, `2.0.0-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/centos/5/x86_64/Dockerfile)
- [`1.8.2-centos-5-x86_64`, `1.8.2-centos-5`, `1.8-centos-5-x86_64`, `1.8-centos-5`, `1-centos-5-x86_64`, `1-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/centos/5/x86_64/Dockerfile)
- [`1.8.1-centos-5-x86_64`, `1.8.1-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/centos/5/x86_64/Dockerfile)
- [`1.8.0-centos-5-x86_64`, `1.8.0-centos-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/centos/5/x86_64/Dockerfile)

#### Debian 10

- [`2.4.1-debian-10-x86_64`, `2.4.1-debian-10`, `2.4.1-debian`, `2.4-debian-10-x86_64`, `2.4-debian-10`, `2.4-debian`, `2-debian-10-x86_64`, `2-debian-10`, `2-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/10/x86_64/Dockerfile)

#### Debian 9

- [`2.4.1-debian-9-x86_64`, `2.4.1-debian-9`, `2.4-debian-9-x86_64`, `2.4-debian-9`, `2-debian-9-x86_64`, `2-debian-9`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/9/x86_64/Dockerfile)
- [`2.4.0-debian-9-x86_64`, `2.4.0-debian-9`, `2.4.0-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/9/x86_64/Dockerfile)
- [`2.3.1-debian-9-x86_64`, `2.3.1-debian-9`, `2.3.1-debian`, `2.3-debian-9-x86_64`, `2.3-debian-9`, `2.3-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/9/x86_64/Dockerfile)
- [`2.3.0-debian-9-x86_64`, `2.3.0-debian-9`, `2.3.0-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/9/x86_64/Dockerfile)
- [`2.2.0-debian-9-x86_64`, `2.2.0-debian-9`, `2.2.0-debian`, `2.2-debian-9-x86_64`, `2.2-debian-9`, `2.2-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/9/x86_64/Dockerfile)
- [`2.1.0-debian-9-x86_64`, `2.1.0-debian-9`, `2.1.0-debian`, `2.1-debian-9-x86_64`, `2.1-debian-9`, `2.1-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/9/x86_64/Dockerfile)
- [`2.0.1-debian-9-x86_64`, `2.0.1-debian-9`, `2.0.1-debian`, `2.0-debian-9-x86_64`, `2.0-debian-9`, `2.0-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/9/x86_64/Dockerfile)
- [`2.0.0-debian-9-x86_64`, `2.0.0-debian-9`, `2.0.0-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/9/x86_64/Dockerfile)
- [`1.8.2-debian-9-x86_64`, `1.8.2-debian-9`, `1.8.2-debian`, `1.8-debian-9-x86_64`, `1.8-debian-9`, `1.8-debian`, `1-debian-9-x86_64`, `1-debian-9`, `1-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/9/x86_64/Dockerfile)
- [`1.8.1-debian-9-x86_64`, `1.8.1-debian-9`, `1.8.1-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/9/x86_64/Dockerfile)
- [`1.8.0-debian-9-x86_64`, `1.8.0-debian-9`, `1.8.0-debian`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/9/x86_64/Dockerfile)

#### Debian 8

- [`2.4.1-debian-8-x86_64`, `2.4.1-debian-8`, `2.4-debian-8-x86_64`, `2.4-debian-8`, `2-debian-8-x86_64`, `2-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/8/x86_64/Dockerfile)
- [`2.4.0-debian-8-x86_64`, `2.4.0-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/8/x86_64/Dockerfile)
- [`2.3.1-debian-8-x86_64`, `2.3.1-debian-8`, `2.3-debian-8-x86_64`, `2.3-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/8/x86_64/Dockerfile)
- [`2.3.0-debian-8-x86_64`, `2.3.0-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/8/x86_64/Dockerfile)
- [`2.2.0-debian-8-x86_64`, `2.2.0-debian-8`, `2.2-debian-8-x86_64`, `2.2-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/8/x86_64/Dockerfile)
- [`2.1.0-debian-8-x86_64`, `2.1.0-debian-8`, `2.1-debian-8-x86_64`, `2.1-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/8/x86_64/Dockerfile)
- [`2.0.1-debian-8-x86_64`, `2.0.1-debian-8`, `2.0-debian-8-x86_64`, `2.0-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/8/x86_64/Dockerfile)
- [`2.0.0-debian-8-x86_64`, `2.0.0-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/8/x86_64/Dockerfile)
- [`1.8.2-debian-8-x86_64`, `1.8.2-debian-8`, `1.8-debian-8-x86_64`, `1.8-debian-8`, `1-debian-8-x86_64`, `1-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/8/x86_64/Dockerfile)
- [`1.8.1-debian-8-x86_64`, `1.8.1-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/8/x86_64/Dockerfile)
- [`1.8.0-debian-8-x86_64`, `1.8.0-debian-8`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/8/x86_64/Dockerfile)

#### Debian 7

- [`2.4.1-debian-7-x86_64`, `2.4.1-debian-7`, `2.4-debian-7-x86_64`, `2.4-debian-7`, `2-debian-7-x86_64`, `2-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/7/x86_64/Dockerfile)
- [`2.4.0-debian-7-x86_64`, `2.4.0-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/7/x86_64/Dockerfile)
- [`2.3.1-debian-7-x86_64`, `2.3.1-debian-7`, `2.3-debian-7-x86_64`, `2.3-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/7/x86_64/Dockerfile)
- [`2.3.0-debian-7-x86_64`, `2.3.0-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/7/x86_64/Dockerfile)
- [`2.2.0-debian-7-x86_64`, `2.2.0-debian-7`, `2.2-debian-7-x86_64`, `2.2-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/7/x86_64/Dockerfile)
- [`2.1.0-debian-7-x86_64`, `2.1.0-debian-7`, `2.1-debian-7-x86_64`, `2.1-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/7/x86_64/Dockerfile)
- [`2.0.1-debian-7-x86_64`, `2.0.1-debian-7`, `2.0-debian-7-x86_64`, `2.0-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/7/x86_64/Dockerfile)
- [`2.0.0-debian-7-x86_64`, `2.0.0-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/7/x86_64/Dockerfile)
- [`1.8.2-debian-7-x86_64`, `1.8.2-debian-7`, `1.8-debian-7-x86_64`, `1.8-debian-7`, `1-debian-7-x86_64`, `1-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/7/x86_64/Dockerfile)
- [`1.8.1-debian-7-x86_64`, `1.8.1-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/7/x86_64/Dockerfile)
- [`1.8.0-debian-7-x86_64`, `1.8.0-debian-7`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/7/x86_64/Dockerfile)

#### Debian 6

- [`2.4.1-debian-6-x86_64`, `2.4.1-debian-6`, `2.4-debian-6-x86_64`, `2.4-debian-6`, `2-debian-6-x86_64`, `2-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/6/x86_64/Dockerfile)
- [`2.4.0-debian-6-x86_64`, `2.4.0-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/6/x86_64/Dockerfile)
- [`2.3.1-debian-6-x86_64`, `2.3.1-debian-6`, `2.3-debian-6-x86_64`, `2.3-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/6/x86_64/Dockerfile)
- [`2.3.0-debian-6-x86_64`, `2.3.0-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/6/x86_64/Dockerfile)
- [`2.2.0-debian-6-x86_64`, `2.2.0-debian-6`, `2.2-debian-6-x86_64`, `2.2-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/6/x86_64/Dockerfile)
- [`2.1.0-debian-6-x86_64`, `2.1.0-debian-6`, `2.1-debian-6-x86_64`, `2.1-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/6/x86_64/Dockerfile)
- [`2.0.1-debian-6-x86_64`, `2.0.1-debian-6`, `2.0-debian-6-x86_64`, `2.0-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/6/x86_64/Dockerfile)
- [`2.0.0-debian-6-x86_64`, `2.0.0-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/6/x86_64/Dockerfile)
- [`1.8.2-debian-6-x86_64`, `1.8.2-debian-6`, `1.8-debian-6-x86_64`, `1.8-debian-6`, `1-debian-6-x86_64`, `1-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/6/x86_64/Dockerfile)
- [`1.8.1-debian-6-x86_64`, `1.8.1-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/6/x86_64/Dockerfile)
- [`1.8.0-debian-6-x86_64`, `1.8.0-debian-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/6/x86_64/Dockerfile)

#### Debian 5

- [`2.4.1-debian-5-x86_64`, `2.4.1-debian-5`, `2.4-debian-5-x86_64`, `2.4-debian-5`, `2-debian-5-x86_64`, `2-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/5/x86_64/Dockerfile)
- [`2.4.0-debian-5-x86_64`, `2.4.0-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/5/x86_64/Dockerfile)
- [`2.3.1-debian-5-x86_64`, `2.3.1-debian-5`, `2.3-debian-5-x86_64`, `2.3-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/5/x86_64/Dockerfile)
- [`2.3.0-debian-5-x86_64`, `2.3.0-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/5/x86_64/Dockerfile)
- [`2.2.0-debian-5-x86_64`, `2.2.0-debian-5`, `2.2-debian-5-x86_64`, `2.2-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/5/x86_64/Dockerfile)
- [`2.1.0-debian-5-x86_64`, `2.1.0-debian-5`, `2.1-debian-5-x86_64`, `2.1-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/5/x86_64/Dockerfile)
- [`2.0.1-debian-5-x86_64`, `2.0.1-debian-5`, `2.0-debian-5-x86_64`, `2.0-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/5/x86_64/Dockerfile)
- [`2.0.0-debian-5-x86_64`, `2.0.0-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/5/x86_64/Dockerfile)
- [`1.8.2-debian-5-x86_64`, `1.8.2-debian-5`, `1.8-debian-5-x86_64`, `1.8-debian-5`, `1-debian-5-x86_64`, `1-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/5/x86_64/Dockerfile)
- [`1.8.1-debian-5-x86_64`, `1.8.1-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/5/x86_64/Dockerfile)
- [`1.8.0-debian-5-x86_64`, `1.8.0-debian-5`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/5/x86_64/Dockerfile)

#### OpenSUSE 15

- [`2.4.1-opensuse-15-x86_64`, `2.4.1-opensuse-15`, `2.4.1-opensuse`, `2.4-opensuse-15-x86_64`, `2.4-opensuse-15`, `2.4-opensuse`, `2-opensuse-15-x86_64`, `2-opensuse-15`, `2-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/opensuse/15/x86_64/Dockerfile)
- [`2.4.0-opensuse-15-x86_64`, `2.4.0-opensuse-15`, `2.4.0-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/opensuse/15/x86_64/Dockerfile)
- [`2.3.1-opensuse-15-x86_64`, `2.3.1-opensuse-15`, `2.3.1-opensuse`, `2.3-opensuse-15-x86_64`, `2.3-opensuse-15`, `2.3-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/opensuse/15/x86_64/Dockerfile)
- [`2.3.0-opensuse-15-x86_64`, `2.3.0-opensuse-15`, `2.3.0-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/opensuse/15/x86_64/Dockerfile)
- [`2.2.0-opensuse-15-x86_64`, `2.2.0-opensuse-15`, `2.2.0-opensuse`, `2.2-opensuse-15-x86_64`, `2.2-opensuse-15`, `2.2-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/opensuse/15/x86_64/Dockerfile)
- [`2.1.0-opensuse-15-x86_64`, `2.1.0-opensuse-15`, `2.1.0-opensuse`, `2.1-opensuse-15-x86_64`, `2.1-opensuse-15`, `2.1-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/opensuse/15/x86_64/Dockerfile)

#### OpenSUSE 42

- [`2.4.1-opensuse-42-x86_64`, `2.4.1-opensuse-42`, `2.4-opensuse-42-x86_64`, `2.4-opensuse-42`, `2-opensuse-42-x86_64`, `2-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/opensuse/42/x86_64/Dockerfile)
- [`2.4.0-opensuse-42-x86_64`, `2.4.0-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/opensuse/42/x86_64/Dockerfile)
- [`2.3.1-opensuse-42-x86_64`, `2.3.1-opensuse-42`, `2.3-opensuse-42-x86_64`, `2.3-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/opensuse/42/x86_64/Dockerfile)
- [`2.3.0-opensuse-42-x86_64`, `2.3.0-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/opensuse/42/x86_64/Dockerfile)
- [`2.2.0-opensuse-42-x86_64`, `2.2.0-opensuse-42`, `2.2-opensuse-42-x86_64`, `2.2-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/opensuse/42/x86_64/Dockerfile)
- [`2.1.0-opensuse-42-x86_64`, `2.1.0-opensuse-42`, `2.1-opensuse-42-x86_64`, `2.1-opensuse-42`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/opensuse/42/x86_64/Dockerfile)
- [`2.0.1-opensuse-42-x86_64`, `2.0.1-opensuse-42`, `2.0.1-opensuse`, `2.0-opensuse-42-x86_64`, `2.0-opensuse-42`, `2.0-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/opensuse/42/x86_64/Dockerfile)
- [`2.0.0-opensuse-42-x86_64`, `2.0.0-opensuse-42`, `2.0.0-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/opensuse/42/x86_64/Dockerfile)
- [`1.8.2-opensuse-42-x86_64`, `1.8.2-opensuse-42`, `1.8.2-opensuse`, `1.8-opensuse-42-x86_64`, `1.8-opensuse-42`, `1.8-opensuse`, `1-opensuse-42-x86_64`, `1-opensuse-42`, `1-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/opensuse/42/x86_64/Dockerfile)
- [`1.8.1-opensuse-42-x86_64`, `1.8.1-opensuse-42`, `1.8.1-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/opensuse/42/x86_64/Dockerfile)
- [`1.8.0-opensuse-42-x86_64`, `1.8.0-opensuse-42`, `1.8.0-opensuse`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/opensuse/42/x86_64/Dockerfile)

#### OpenSUSE 13

- [`2.4.1-opensuse-13-x86_64`, `2.4.1-opensuse-13`, `2.4-opensuse-13-x86_64`, `2.4-opensuse-13`, `2-opensuse-13-x86_64`, `2-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/opensuse/13/x86_64/Dockerfile)
- [`2.4.0-opensuse-13-x86_64`, `2.4.0-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/opensuse/13/x86_64/Dockerfile)
- [`2.3.1-opensuse-13-x86_64`, `2.3.1-opensuse-13`, `2.3-opensuse-13-x86_64`, `2.3-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/opensuse/13/x86_64/Dockerfile)
- [`2.3.0-opensuse-13-x86_64`, `2.3.0-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/opensuse/13/x86_64/Dockerfile)
- [`2.2.0-opensuse-13-x86_64`, `2.2.0-opensuse-13`, `2.2-opensuse-13-x86_64`, `2.2-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/opensuse/13/x86_64/Dockerfile)
- [`2.1.0-opensuse-13-x86_64`, `2.1.0-opensuse-13`, `2.1-opensuse-13-x86_64`, `2.1-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/opensuse/13/x86_64/Dockerfile)
- [`2.0.1-opensuse-13-x86_64`, `2.0.1-opensuse-13`, `2.0-opensuse-13-x86_64`, `2.0-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/opensuse/13/x86_64/Dockerfile)
- [`2.0.0-opensuse-13-x86_64`, `2.0.0-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/opensuse/13/x86_64/Dockerfile)
- [`1.8.2-opensuse-13-x86_64`, `1.8.2-opensuse-13`, `1.8-opensuse-13-x86_64`, `1.8-opensuse-13`, `1-opensuse-13-x86_64`, `1-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/opensuse/13/x86_64/Dockerfile)
- [`1.8.1-opensuse-13-x86_64`, `1.8.1-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/opensuse/13/x86_64/Dockerfile)
- [`1.8.0-opensuse-13-x86_64`, `1.8.0-opensuse-13`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/opensuse/13/x86_64/Dockerfile)

#### Scientific Linux 7

- [`2.4.1-scientific-7-x86_64`, `2.4.1-scientific-7`, `2.4.1-scientific`, `2.4-scientific-7-x86_64`, `2.4-scientific-7`, `2.4-scientific`, `2-scientific-7-x86_64`, `2-scientific-7`, `2-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/scientific/7/x86_64/Dockerfile)
- [`2.4.0-scientific-7-x86_64`, `2.4.0-scientific-7`, `2.4.0-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/scientific/7/x86_64/Dockerfile)
- [`2.3.1-scientific-7-x86_64`, `2.3.1-scientific-7`, `2.3.1-scientific`, `2.3-scientific-7-x86_64`, `2.3-scientific-7`, `2.3-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/scientific/7/x86_64/Dockerfile)
- [`2.3.0-scientific-7-x86_64`, `2.3.0-scientific-7`, `2.3.0-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/scientific/7/x86_64/Dockerfile)
- [`2.2.0-scientific-7-x86_64`, `2.2.0-scientific-7`, `2.2.0-scientific`, `2.2-scientific-7-x86_64`, `2.2-scientific-7`, `2.2-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/scientific/7/x86_64/Dockerfile)
- [`2.1.0-scientific-7-x86_64`, `2.1.0-scientific-7`, `2.1.0-scientific`, `2.1-scientific-7-x86_64`, `2.1-scientific-7`, `2.1-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/scientific/7/x86_64/Dockerfile)
- [`2.0.1-scientific-7-x86_64`, `2.0.1-scientific-7`, `2.0.1-scientific`, `2.0-scientific-7-x86_64`, `2.0-scientific-7`, `2.0-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/scientific/7/x86_64/Dockerfile)
- [`2.0.0-scientific-7-x86_64`, `2.0.0-scientific-7`, `2.0.0-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/scientific/7/x86_64/Dockerfile)
- [`1.8.2-scientific-7-x86_64`, `1.8.2-scientific-7`, `1.8.2-scientific`, `1.8-scientific-7-x86_64`, `1.8-scientific-7`, `1.8-scientific`, `1-scientific-7-x86_64`, `1-scientific-7`, `1-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/scientific/7/x86_64/Dockerfile)
- [`1.8.1-scientific-7-x86_64`, `1.8.1-scientific-7`, `1.8.1-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/scientific/7/x86_64/Dockerfile)
- [`1.8.0-scientific-7-x86_64`, `1.8.0-scientific-7`, `1.8.0-scientific`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/scientific/7/x86_64/Dockerfile)

#### Scientific Linux 6

- [`2.4.1-scientific-6-x86_64`, `2.4.1-scientific-6`, `2.4-scientific-6-x86_64`, `2.4-scientific-6`, `2-scientific-6-x86_64`, `2-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/scientific/6/x86_64/Dockerfile)
- [`2.4.0-scientific-6-x86_64`, `2.4.0-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/scientific/6/x86_64/Dockerfile)
- [`2.3.1-scientific-6-x86_64`, `2.3.1-scientific-6`, `2.3-scientific-6-x86_64`, `2.3-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/scientific/6/x86_64/Dockerfile)
- [`2.3.0-scientific-6-x86_64`, `2.3.0-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/scientific/6/x86_64/Dockerfile)
- [`2.2.0-scientific-6-x86_64`, `2.2.0-scientific-6`, `2.2-scientific-6-x86_64`, `2.2-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/scientific/6/x86_64/Dockerfile)
- [`2.1.0-scientific-6-x86_64`, `2.1.0-scientific-6`, `2.1-scientific-6-x86_64`, `2.1-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/scientific/6/x86_64/Dockerfile)
- [`2.0.1-scientific-6-x86_64`, `2.0.1-scientific-6`, `2.0-scientific-6-x86_64`, `2.0-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/scientific/6/x86_64/Dockerfile)
- [`2.0.0-scientific-6-x86_64`, `2.0.0-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/scientific/6/x86_64/Dockerfile)
- [`1.8.2-scientific-6-x86_64`, `1.8.2-scientific-6`, `1.8-scientific-6-x86_64`, `1.8-scientific-6`, `1-scientific-6-x86_64`, `1-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/scientific/6/x86_64/Dockerfile)
- [`1.8.1-scientific-6-x86_64`, `1.8.1-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/scientific/6/x86_64/Dockerfile)
- [`1.8.0-scientific-6-x86_64`, `1.8.0-scientific-6`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/scientific/6/x86_64/Dockerfile)

#### Ubuntu 18.04

- [`2.4.1-ubuntu-18.04-x86_64`, `2.4.1-ubuntu-18.04`, `2.4.1-ubuntu`, `2.4-ubuntu-18.04-x86_64`, `2.4-ubuntu-18.04`, `2.4-ubuntu`, `2-ubuntu-18.04-x86_64`, `2-ubuntu-18.04`, `2-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/18.04/x86_64/Dockerfile)
- [`2.4.0-ubuntu-18.04-x86_64`, `2.4.0-ubuntu-18.04`, `2.4.0-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/18.04/x86_64/Dockerfile)
- [`2.3.1-ubuntu-18.04-x86_64`, `2.3.1-ubuntu-18.04`, `2.3.1-ubuntu`, `2.3-ubuntu-18.04-x86_64`, `2.3-ubuntu-18.04`, `2.3-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/18.04/x86_64/Dockerfile)
- [`2.3.0-ubuntu-18.04-x86_64`, `2.3.0-ubuntu-18.04`, `2.3.0-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/18.04/x86_64/Dockerfile)
- [`2.2.0-ubuntu-18.04-x86_64`, `2.2.0-ubuntu-18.04`, `2.2.0-ubuntu`, `2.2-ubuntu-18.04-x86_64`, `2.2-ubuntu-18.04`, `2.2-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/18.04/x86_64/Dockerfile)
- [`2.1.0-ubuntu-18.04-x86_64`, `2.1.0-ubuntu-18.04`, `2.1.0-ubuntu`, `2.1-ubuntu-18.04-x86_64`, `2.1-ubuntu-18.04`, `2.1-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/18.04/x86_64/Dockerfile)
- [`2.0.1-ubuntu-18.04-x86_64`, `2.0.1-ubuntu-18.04`, `2.0.1-ubuntu`, `2.0-ubuntu-18.04-x86_64`, `2.0-ubuntu-18.04`, `2.0-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/18.04/x86_64/Dockerfile)
- [`2.0.0-ubuntu-18.04-x86_64`, `2.0.0-ubuntu-18.04`, `2.0.0-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/18.04/x86_64/Dockerfile)
- [`1.8.2-ubuntu-18.04-x86_64`, `1.8.2-ubuntu-18.04`, `1.8.2-ubuntu`, `1.8-ubuntu-18.04-x86_64`, `1.8-ubuntu-18.04`, `1.8-ubuntu`, `1-ubuntu-18.04-x86_64`, `1-ubuntu-18.04`, `1-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/18.04/x86_64/Dockerfile)
- [`1.8.1-ubuntu-18.04-x86_64`, `1.8.1-ubuntu-18.04`, `1.8.1-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/18.04/x86_64/Dockerfile)
- [`1.8.0-ubuntu-18.04-x86_64`, `1.8.0-ubuntu-18.04`, `1.8.0-ubuntu`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/18.04/x86_64/Dockerfile)

#### Ubuntu 16.04

- [`2.4.1-ubuntu-16.04-x86_64`, `2.4.1-ubuntu-16.04`, `2.4-ubuntu-16.04-x86_64`, `2.4-ubuntu-16.04`, `2-ubuntu-16.04-x86_64`, `2-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/16.04/x86_64/Dockerfile)
- [`2.4.0-ubuntu-16.04-x86_64`, `2.4.0-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/16.04/x86_64/Dockerfile)
- [`2.3.1-ubuntu-16.04-x86_64`, `2.3.1-ubuntu-16.04`, `2.3-ubuntu-16.04-x86_64`, `2.3-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/16.04/x86_64/Dockerfile)
- [`2.3.0-ubuntu-16.04-x86_64`, `2.3.0-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/16.04/x86_64/Dockerfile)
- [`2.2.0-ubuntu-16.04-x86_64`, `2.2.0-ubuntu-16.04`, `2.2-ubuntu-16.04-x86_64`, `2.2-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/16.04/x86_64/Dockerfile)
- [`2.1.0-ubuntu-16.04-x86_64`, `2.1.0-ubuntu-16.04`, `2.1-ubuntu-16.04-x86_64`, `2.1-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/16.04/x86_64/Dockerfile)
- [`2.0.1-ubuntu-16.04-x86_64`, `2.0.1-ubuntu-16.04`, `2.0-ubuntu-16.04-x86_64`, `2.0-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/16.04/x86_64/Dockerfile)
- [`2.0.0-ubuntu-16.04-x86_64`, `2.0.0-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/16.04/x86_64/Dockerfile)
- [`1.8.2-ubuntu-16.04-x86_64`, `1.8.2-ubuntu-16.04`, `1.8-ubuntu-16.04-x86_64`, `1.8-ubuntu-16.04`, `1-ubuntu-16.04-x86_64`, `1-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/16.04/x86_64/Dockerfile)
- [`1.8.1-ubuntu-16.04-x86_64`, `1.8.1-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/16.04/x86_64/Dockerfile)
- [`1.8.0-ubuntu-16.04-x86_64`, `1.8.0-ubuntu-16.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/16.04/x86_64/Dockerfile)

#### Ubuntu 14.04

- [`2.4.1-ubuntu-14.04-x86_64`, `2.4.1-ubuntu-14.04`, `2.4-ubuntu-14.04-x86_64`, `2.4-ubuntu-14.04`, `2-ubuntu-14.04-x86_64`, `2-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/14.04/x86_64/Dockerfile)
- [`2.4.0-ubuntu-14.04-x86_64`, `2.4.0-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/14.04/x86_64/Dockerfile)
- [`2.3.1-ubuntu-14.04-x86_64`, `2.3.1-ubuntu-14.04`, `2.3-ubuntu-14.04-x86_64`, `2.3-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/14.04/x86_64/Dockerfile)
- [`2.3.0-ubuntu-14.04-x86_64`, `2.3.0-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/14.04/x86_64/Dockerfile)
- [`2.2.0-ubuntu-14.04-x86_64`, `2.2.0-ubuntu-14.04`, `2.2-ubuntu-14.04-x86_64`, `2.2-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/14.04/x86_64/Dockerfile)
- [`2.1.0-ubuntu-14.04-x86_64`, `2.1.0-ubuntu-14.04`, `2.1-ubuntu-14.04-x86_64`, `2.1-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/14.04/x86_64/Dockerfile)
- [`2.0.1-ubuntu-14.04-x86_64`, `2.0.1-ubuntu-14.04`, `2.0-ubuntu-14.04-x86_64`, `2.0-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/14.04/x86_64/Dockerfile)
- [`2.0.0-ubuntu-14.04-x86_64`, `2.0.0-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/14.04/x86_64/Dockerfile)
- [`1.8.2-ubuntu-14.04-x86_64`, `1.8.2-ubuntu-14.04`, `1.8-ubuntu-14.04-x86_64`, `1.8-ubuntu-14.04`, `1-ubuntu-14.04-x86_64`, `1-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/14.04/x86_64/Dockerfile)
- [`1.8.1-ubuntu-14.04-x86_64`, `1.8.1-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/14.04/x86_64/Dockerfile)
- [`1.8.0-ubuntu-14.04-x86_64`, `1.8.0-ubuntu-14.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/14.04/x86_64/Dockerfile)

#### Ubuntu 12.04

- [`2.4.1-ubuntu-12.04-x86_64`, `2.4.1-ubuntu-12.04`, `2.4-ubuntu-12.04-x86_64`, `2.4-ubuntu-12.04`, `2-ubuntu-12.04-x86_64`, `2-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/12.04/x86_64/Dockerfile)
- [`2.4.0-ubuntu-12.04-x86_64`, `2.4.0-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/12.04/x86_64/Dockerfile)
- [`2.3.1-ubuntu-12.04-x86_64`, `2.3.1-ubuntu-12.04`, `2.3-ubuntu-12.04-x86_64`, `2.3-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/12.04/x86_64/Dockerfile)
- [`2.3.0-ubuntu-12.04-x86_64`, `2.3.0-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/12.04/x86_64/Dockerfile)
- [`2.2.0-ubuntu-12.04-x86_64`, `2.2.0-ubuntu-12.04`, `2.2-ubuntu-12.04-x86_64`, `2.2-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/12.04/x86_64/Dockerfile)
- [`2.1.0-ubuntu-12.04-x86_64`, `2.1.0-ubuntu-12.04`, `2.1-ubuntu-12.04-x86_64`, `2.1-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/12.04/x86_64/Dockerfile)
- [`2.0.1-ubuntu-12.04-x86_64`, `2.0.1-ubuntu-12.04`, `2.0-ubuntu-12.04-x86_64`, `2.0-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/12.04/x86_64/Dockerfile)
- [`2.0.0-ubuntu-12.04-x86_64`, `2.0.0-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/12.04/x86_64/Dockerfile)
- [`1.8.2-ubuntu-12.04-x86_64`, `1.8.2-ubuntu-12.04`, `1.8-ubuntu-12.04-x86_64`, `1.8-ubuntu-12.04`, `1-ubuntu-12.04-x86_64`, `1-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/12.04/x86_64/Dockerfile)
- [`1.8.1-ubuntu-12.04-x86_64`, `1.8.1-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/12.04/x86_64/Dockerfile)
- [`1.8.0-ubuntu-12.04-x86_64`, `1.8.0-ubuntu-12.04`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/12.04/x86_64/Dockerfile)

### i386 architecture

Supported platforms:

- [Alpine 3.10](#alpine-310-i386) · [3.9](#alpine-39-i386)
- [CentOS 6](#centos-6-i386) · [5](#centos-5-i386)
- [Debian 10](#debian-10-i386) · [9](#debian-9-i386) · [8](#debian-8-i386) · [7](#debian-7-i386) · [6](#debian-6-i386)
- [Ubuntu 18.04](#ubuntu-1804-i386) · [16.04](#ubuntu-1604-i386) · [14.04](#ubuntu-1404-i386) · [12.04](#ubuntu-1204-i386)

#### Alpine 3.10 (i386)

- [`2.4.1-alpine-3.10-i386`, `2.4-alpine-3.10-i386`, `2-alpine-3.10-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/alpine/3.10/i386/Dockerfile)

#### Alpine 3.9 (i386)

- [`2.4.1-alpine-3.9-i386`, `2.4-alpine-3.9-i386`, `2-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/alpine/3.9/i386/Dockerfile)
- [`2.4.0-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/alpine/3.9/i386/Dockerfile)
- [`2.3.1-alpine-3.9-i386`, `2.3-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/alpine/3.9/i386/Dockerfile)
- [`2.3.0-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/alpine/3.9/i386/Dockerfile)
- [`2.2.0-alpine-3.9-i386`, `2.2-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/alpine/3.9/i386/Dockerfile)
- [`2.1.0-alpine-3.9-i386`, `2.1-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/alpine/3.9/i386/Dockerfile)
- [`2.0.1-alpine-3.9-i386`, `2.0-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/alpine/3.9/i386/Dockerfile)
- [`2.0.0-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/alpine/3.9/i386/Dockerfile)
- [`1.8.2-alpine-3.9-i386`, `1.8-alpine-3.9-i386`, `1-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/alpine/3.9/i386/Dockerfile)
- [`1.8.1-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/alpine/3.9/i386/Dockerfile)
- [`1.8.0-alpine-3.9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/alpine/3.9/i386/Dockerfile)

#### CentOS 6 (i386)

- [`2.4.1-centos-6-i386`, `2.4-centos-6-i386`, `2-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/centos/6/i386/Dockerfile)
- [`2.4.0-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/centos/6/i386/Dockerfile)
- [`2.3.1-centos-6-i386`, `2.3-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/centos/6/i386/Dockerfile)
- [`2.3.0-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/centos/6/i386/Dockerfile)
- [`2.2.0-centos-6-i386`, `2.2-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/centos/6/i386/Dockerfile)
- [`2.1.0-centos-6-i386`, `2.1-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/centos/6/i386/Dockerfile)
- [`2.0.1-centos-6-i386`, `2.0-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/centos/6/i386/Dockerfile)
- [`2.0.0-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/centos/6/i386/Dockerfile)
- [`1.8.2-centos-6-i386`, `1.8-centos-6-i386`, `1-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/centos/6/i386/Dockerfile)
- [`1.8.1-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/centos/6/i386/Dockerfile)
- [`1.8.0-centos-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/centos/6/i386/Dockerfile)

#### CentOS 5 (i386)

- [`2.4.1-centos-5-i386`, `2.4-centos-5-i386`, `2-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/centos/5/i386/Dockerfile)
- [`2.4.0-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/centos/5/i386/Dockerfile)
- [`2.3.1-centos-5-i386`, `2.3-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/centos/5/i386/Dockerfile)
- [`2.3.0-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/centos/5/i386/Dockerfile)
- [`2.2.0-centos-5-i386`, `2.2-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/centos/5/i386/Dockerfile)
- [`2.1.0-centos-5-i386`, `2.1-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/centos/5/i386/Dockerfile)
- [`2.0.1-centos-5-i386`, `2.0-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/centos/5/i386/Dockerfile)
- [`2.0.0-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/centos/5/i386/Dockerfile)
- [`1.8.2-centos-5-i386`, `1.8-centos-5-i386`, `1-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/centos/5/i386/Dockerfile)
- [`1.8.1-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/centos/5/i386/Dockerfile)
- [`1.8.0-centos-5-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/centos/5/i386/Dockerfile)

#### Debian 10 (i386)

- [`2.4.1-debian-10-i386`, `2.4-debian-10-i386`, `2-debian-10-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/10/i386/Dockerfile)

#### Debian 9 (i386)

- [`2.4.1-debian-9-i386`, `2.4-debian-9-i386`, `2-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/9/i386/Dockerfile)
- [`2.4.0-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/9/i386/Dockerfile)
- [`2.3.1-debian-9-i386`, `2.3-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/9/i386/Dockerfile)
- [`2.3.0-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/9/i386/Dockerfile)
- [`2.2.0-debian-9-i386`, `2.2-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/9/i386/Dockerfile)
- [`2.1.0-debian-9-i386`, `2.1-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/9/i386/Dockerfile)
- [`2.0.1-debian-9-i386`, `2.0-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/9/i386/Dockerfile)
- [`2.0.0-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/9/i386/Dockerfile)
- [`1.8.2-debian-9-i386`, `1.8-debian-9-i386`, `1-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/9/i386/Dockerfile)
- [`1.8.1-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/9/i386/Dockerfile)
- [`1.8.0-debian-9-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/9/i386/Dockerfile)

#### Debian 8 (i386)

- [`2.4.1-debian-8-i386`, `2.4-debian-8-i386`, `2-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/8/i386/Dockerfile)
- [`2.4.0-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/8/i386/Dockerfile)
- [`2.3.1-debian-8-i386`, `2.3-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/8/i386/Dockerfile)
- [`2.3.0-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/8/i386/Dockerfile)
- [`2.2.0-debian-8-i386`, `2.2-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/8/i386/Dockerfile)
- [`2.1.0-debian-8-i386`, `2.1-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/8/i386/Dockerfile)
- [`2.0.1-debian-8-i386`, `2.0-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/8/i386/Dockerfile)
- [`2.0.0-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/8/i386/Dockerfile)
- [`1.8.2-debian-8-i386`, `1.8-debian-8-i386`, `1-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/8/i386/Dockerfile)
- [`1.8.1-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/8/i386/Dockerfile)
- [`1.8.0-debian-8-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/8/i386/Dockerfile)

#### Debian 7 (i386)

- [`2.4.1-debian-7-i386`, `2.4-debian-7-i386`, `2-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/7/i386/Dockerfile)
- [`2.4.0-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/7/i386/Dockerfile)
- [`2.3.1-debian-7-i386`, `2.3-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/7/i386/Dockerfile)
- [`2.3.0-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/7/i386/Dockerfile)
- [`2.2.0-debian-7-i386`, `2.2-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/7/i386/Dockerfile)
- [`2.1.0-debian-7-i386`, `2.1-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/7/i386/Dockerfile)
- [`2.0.1-debian-7-i386`, `2.0-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/7/i386/Dockerfile)
- [`2.0.0-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/7/i386/Dockerfile)
- [`1.8.2-debian-7-i386`, `1.8-debian-7-i386`, `1-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/7/i386/Dockerfile)
- [`1.8.1-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/7/i386/Dockerfile)
- [`1.8.0-debian-7-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/7/i386/Dockerfile)

#### Debian 6 (i386)

- [`2.4.1-debian-6-i386`, `2.4-debian-6-i386`, `2-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/debian/6/i386/Dockerfile)
- [`2.4.0-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/debian/6/i386/Dockerfile)
- [`2.3.1-debian-6-i386`, `2.3-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/debian/6/i386/Dockerfile)
- [`2.3.0-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/debian/6/i386/Dockerfile)
- [`2.2.0-debian-6-i386`, `2.2-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/debian/6/i386/Dockerfile)
- [`2.1.0-debian-6-i386`, `2.1-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/debian/6/i386/Dockerfile)
- [`2.0.1-debian-6-i386`, `2.0-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/debian/6/i386/Dockerfile)
- [`2.0.0-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/debian/6/i386/Dockerfile)
- [`1.8.2-debian-6-i386`, `1.8-debian-6-i386`, `1-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/debian/6/i386/Dockerfile)
- [`1.8.1-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/debian/6/i386/Dockerfile)
- [`1.8.0-debian-6-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/debian/6/i386/Dockerfile)

#### Ubuntu 18.04 (i386)

- [`2.4.1-ubuntu-18.04-i386`, `2.4-ubuntu-18.04-i386`, `2-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/18.04/i386/Dockerfile)
- [`2.4.0-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/18.04/i386/Dockerfile)
- [`2.3.1-ubuntu-18.04-i386`, `2.3-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/18.04/i386/Dockerfile)
- [`2.3.0-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/18.04/i386/Dockerfile)
- [`2.2.0-ubuntu-18.04-i386`, `2.2-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/18.04/i386/Dockerfile)
- [`2.1.0-ubuntu-18.04-i386`, `2.1-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/18.04/i386/Dockerfile)
- [`2.0.1-ubuntu-18.04-i386`, `2.0-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/18.04/i386/Dockerfile)
- [`2.0.0-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/18.04/i386/Dockerfile)
- [`1.8.2-ubuntu-18.04-i386`, `1.8-ubuntu-18.04-i386`, `1-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/18.04/i386/Dockerfile)
- [`1.8.1-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/18.04/i386/Dockerfile)
- [`1.8.0-ubuntu-18.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/18.04/i386/Dockerfile)

#### Ubuntu 16.04 (i386)

- [`2.4.1-ubuntu-16.04-i386`, `2.4-ubuntu-16.04-i386`, `2-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/16.04/i386/Dockerfile)
- [`2.4.0-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/16.04/i386/Dockerfile)
- [`2.3.1-ubuntu-16.04-i386`, `2.3-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/16.04/i386/Dockerfile)
- [`2.3.0-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/16.04/i386/Dockerfile)
- [`2.2.0-ubuntu-16.04-i386`, `2.2-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/16.04/i386/Dockerfile)
- [`2.1.0-ubuntu-16.04-i386`, `2.1-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/16.04/i386/Dockerfile)
- [`2.0.1-ubuntu-16.04-i386`, `2.0-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/16.04/i386/Dockerfile)
- [`2.0.0-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/16.04/i386/Dockerfile)
- [`1.8.2-ubuntu-16.04-i386`, `1.8-ubuntu-16.04-i386`, `1-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/16.04/i386/Dockerfile)
- [`1.8.1-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/16.04/i386/Dockerfile)
- [`1.8.0-ubuntu-16.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/16.04/i386/Dockerfile)

#### Ubuntu 14.04 (i386)

- [`2.4.1-ubuntu-14.04-i386`, `2.4-ubuntu-14.04-i386`, `2-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/14.04/i386/Dockerfile)
- [`2.4.0-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/14.04/i386/Dockerfile)
- [`2.3.1-ubuntu-14.04-i386`, `2.3-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/14.04/i386/Dockerfile)
- [`2.3.0-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/14.04/i386/Dockerfile)
- [`2.2.0-ubuntu-14.04-i386`, `2.2-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/14.04/i386/Dockerfile)
- [`2.1.0-ubuntu-14.04-i386`, `2.1-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/14.04/i386/Dockerfile)
- [`2.0.1-ubuntu-14.04-i386`, `2.0-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/14.04/i386/Dockerfile)
- [`2.0.0-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/14.04/i386/Dockerfile)
- [`1.8.2-ubuntu-14.04-i386`, `1.8-ubuntu-14.04-i386`, `1-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/14.04/i386/Dockerfile)
- [`1.8.1-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/14.04/i386/Dockerfile)
- [`1.8.0-ubuntu-14.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/14.04/i386/Dockerfile)

#### Ubuntu 12.04 (i386)

- [`2.4.1-ubuntu-12.04-i386`, `2.4-ubuntu-12.04-i386`, `2-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.1-2/ubuntu/12.04/i386/Dockerfile)
- [`2.4.0-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.4.0-1/ubuntu/12.04/i386/Dockerfile)
- [`2.3.1-ubuntu-12.04-i386`, `2.3-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.1-8/ubuntu/12.04/i386/Dockerfile)
- [`2.3.0-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.3.0-1/ubuntu/12.04/i386/Dockerfile)
- [`2.2.0-ubuntu-12.04-i386`, `2.2-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.2.0-3/ubuntu/12.04/i386/Dockerfile)
- [`2.1.0-ubuntu-12.04-i386`, `2.1-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.1.0-2/ubuntu/12.04/i386/Dockerfile)
- [`2.0.1-ubuntu-12.04-i386`, `2.0-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.1-1/ubuntu/12.04/i386/Dockerfile)
- [`2.0.0-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v2.0.0-1/ubuntu/12.04/i386/Dockerfile)
- [`1.8.2-ubuntu-12.04-i386`, `1.8-ubuntu-12.04-i386`, `1-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.2-9/ubuntu/12.04/i386/Dockerfile)
- [`1.8.1-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.1-3/ubuntu/12.04/i386/Dockerfile)
- [`1.8.0-ubuntu-12.04-i386`](https://github.com/cjolowicz/docker-buildbot-worker/blob/v1.8.0-2/ubuntu/12.04/i386/Dockerfile)

## Related projects

- https://github.com/cjolowicz/docker-buildbot
- https://github.com/cjolowicz/buildbot-docker-swarm-worker
