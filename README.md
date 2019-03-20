[![Build Status](https://travis-ci.com/cjolowicz/docker-buildbot-worker.svg?branch=master)](https://travis-ci.com/cjolowicz/docker-buildbot-worker)

# docker-buildbot-worker

This repository contains [buildbot-worker](https://buildbot.net/)
Docker images for the `x86_64` and `i386` architectures, for the
following platforms:

- [Debian 6](debian/6/Dockerfile.m4)
- [Ubuntu 16.04](ubuntu/16.04/Dockerfile.m4)

## Requirements

Building the Docker images requires the
[m4](https://www.gnu.org/software/m4/) preprocessor.

## Usage

Invoke `make` to build the images locally, optionally passing `REPO`
with a Docker Hub repository name. If `DOCKER_USERNAME` is set, `REPO`
defaults to its value.

Invoke `make push` to upload the images.

Invoke `make login` to log into Docker Hub. This requires the
environment variables `DOCKER_USERNAME` and `DOCKER_PASSWORD` to be
set.
