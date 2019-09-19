import click

from .bumpversion import bumpversion
from .images import images
from .m4_makedep import m4_makedep
from .tags import tags
from .write_json import write_json
from .write_readme import write_readme


@click.group()
def run():
    """Command-line interface for docker-buildbot-worker."""


run.add_command(bumpversion)
run.add_command(images)
run.add_command(m4_makedep)
run.add_command(tags)
run.add_command(write_json)
run.add_command(write_readme)
