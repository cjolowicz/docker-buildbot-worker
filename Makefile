export TOPDIR = $(shell pwd)
export REPO = $(DOCKER_USERNAME)

DIRS = alpine/3.9.2 centos/5 debian/6 ubuntu/16.04
ARCHS = x86_64 i386

all: build

prepare:
	set -ex; for dir in $(DIRS) ; do \
	    for arch in $(ARCHS) ; do \
	        $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir ARCH=$$arch Dockerfile.$$arch ; \
	    done ; \
	done

build:
	set -ex; for dir in $(DIRS) ; do \
	    for arch in $(ARCHS) ; do \
	        $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir ARCH=$$arch build ; \
	    done ; \
	done

push:
	set -ex; for dir in $(DIRS) ; do \
	    for arch in $(ARCHS) ; do \
	        $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir ARCH=$$arch push ; \
	    done ; \
	done

login:
	echo "$(DOCKER_PASSWORD)" | docker login -u $(DOCKER_USERNAME) --password-stdin

.PHONY: all prepare build push login
