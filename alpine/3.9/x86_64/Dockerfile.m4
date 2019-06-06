FROM alpine:3.9

m4_include(alpine/buildbot-deps.m4)
RUN mkdir -p /usr/local/src/

m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
