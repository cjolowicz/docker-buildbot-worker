m4_define(
    `M4_ZYPPER_INSTALL',
    set -ex; \
    zypper --non-interactive install \
    `m4_patsubst($1, `[
	 ]+', ` \\
    ')'; \
    zypper clean --all)m4_dnl
