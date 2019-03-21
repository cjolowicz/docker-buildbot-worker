export TOPDIR = $(shell pwd)
export REPO = $(DOCKER_USERNAME)

DIRS = alpine/3.9/x86_64 \
       alpine/3.9/i386 \
       centos/5/x86_64 \
       centos/5/i386 \
       centos/7/x86_64 \
       debian/6/x86_64 \
       debian/6/i386 \
       debian/7/x86_64 \
       debian/7/i386 \
       debian/8/x86_64 \
       debian/8/i386 \
       debian/9/x86_64 \
       debian/9/i386 \
       ubuntu/16.04/x86_64 \
       ubuntu/16.04/i386 \
       ubuntu/18.04/x86_64 \
       ubuntu/18.04/i386

all: build

prepare:
	set -ex; for dir in $(DIRS) ; do \
	    $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir Dockerfile ; \
	done

build:
	set -ex; for dir in $(DIRS) ; do \
	    $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir build ; \
	done

push:
	set -ex; for dir in $(DIRS) ; do \
	    $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir push ; \
	done

pull:
	for dir in $(DIRS) ; do \
	    $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir pull ; \
	done

login:
	echo "$(DOCKER_PASSWORD)" | docker login -u $(DOCKER_USERNAME) --password-stdin

dep:
	set -ex; for dir in $(DIRS) ; do \
	    $(MAKE) -f $(TOPDIR)/Makefile.sub -C $$dir dep ; \
	done

.PHONY: all prepare build push pull login dep
