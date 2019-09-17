import os
import re

import click

from ..core.utils import setify


def _extract_dependencies(filename):
    pattern = r"m4_include\(([^)]*)\)"
    with open(filename) as file:
        for match in re.finditer(pattern, file.read()):
            yield match.group(1)


@setify
def _generate_dependencies(targetdir, filename):
    yield os.path.relpath(filename, targetdir)
    for filename in _extract_dependencies(filename):
        yield from _generate_dependencies(targetdir, filename)


@click.command()
@click.argument("target")
@click.argument("files", nargs=-1, type=click.Path(exists=True))
def generate_m4_dependencies(target, files):
    """Generate m4 dependencies of target from files for Makefile."""
    targetdir, target = os.path.split(target)
    dependencies = sorted(
        dependency
        for filename in files
        for dependency in _generate_dependencies(targetdir, filename)
    )
    for dependency in dependencies:
        click.echo(f"{target}: {dependency}")
