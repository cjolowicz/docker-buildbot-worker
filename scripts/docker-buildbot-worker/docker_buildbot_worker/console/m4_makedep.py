import os
import re

import click

from ..core.utils import setify


def _extract_includes(filename):
    """Return the files directly included by the given file."""
    pattern = r"m4_include\(([^)]*)\)"
    with open(filename) as file:
        for match in re.finditer(pattern, file.read()):
            yield match.group(1)


@setify
def _list_dependencies(filename):
    """Return the file and all directly or indirectly included files."""
    yield filename
    for filename in _extract_includes(filename):
        yield from _list_dependencies(filename)


@click.command()
@click.argument("target")
@click.argument("files", nargs=-1, type=click.Path(exists=True))
def m4_makedep(target, files):
    """List the m4 dependencies of the given target."""
    targetdir, target = os.path.split(target)
    dependencies = sorted(
        os.path.relpath(filename, targetdir)
        for filename in files
        for dependency in _list_dependencies(filename)
    )
    for dependency in dependencies:
        click.echo(f"{target}: {dependency}")
