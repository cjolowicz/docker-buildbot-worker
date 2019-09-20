import os
from tempfile import NamedTemporaryFile

import click

from ..core import locations
from ..core.builder import Builder
from ..core.versions import Version


def _bump(version):
    basedir = os.path.dirname(locations.makefile)

    with open(locations.makefile) as source:
        with NamedTemporaryFile(mode="w", delete=False, dir=basedir) as destination:
            _bumpstream(version, source, destination)

    os.rename(destination.name, locations.makefile)


def _bumpstream(version, source, destination):
    upstream_line = "export BUILDBOT_VERSION = "
    version_line = "export VERSION = $(BUILDBOT_VERSION)-"

    for line in source:
        if line.startswith(upstream_line):
            upstream = Version.format(version.upstream)
            line = f"{upstream_line}{upstream}\n"
        elif line.startswith(version_line):
            line = f"{version_line}{version.downstream}\n"

        print(line, end="", file=destination)


@click.command()
@click.argument("version", required=False)
def bumpversion(version):
    """Bump version.

    If no version is specified, increment the downstream component.
    """
    oldversion = Builder()._worktree_version
    version = (
        Version.parse(version)
        if version
        else Version(*oldversion.upstream, downstream=oldversion.downstream + 1)
    )

    _bump(version)
    click.echo(version)
