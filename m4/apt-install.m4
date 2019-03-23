m4_define(
    `M4_APT_INSTALL',
    set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    `m4_patsubst($1, `[
	 ]+', ` \\
    ')'; \
    rm -rf /var/lib/apt/lists/*)m4_dnl
