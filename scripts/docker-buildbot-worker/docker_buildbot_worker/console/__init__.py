import click

from .expand_tags import expand_tags
from .generate_m4_dependencies import generate_m4_dependencies
from .generate_readme import generate_readme


@click.group()
def run():
    """Scripts for docker-buildbot-worker."""


run.add_command(expand_tags)
run.add_command(generate_m4_dependencies)
run.add_command(generate_readme)
