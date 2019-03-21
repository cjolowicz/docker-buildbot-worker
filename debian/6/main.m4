# allow unauthenticated packages (keys are invalid now)
# https://askubuntu.com/a/74389/469295
RUN echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/10-allow-unauthenticated

m4_include(debian/6/openssl.m4)
m4_include(debian/6/curl.m4)
m4_include(debian/6/python.m4)
m4_include(pip.m4)
m4_include(buildbot.m4)m4_dnl
