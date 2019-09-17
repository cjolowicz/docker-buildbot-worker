import click

from ..core import versions
from ..core.versions import Version
from ..core.images import Image


@click.command()
@click.argument("version")
@click.argument("platform")
@click.argument("release")
@click.argument("architecture")
def expand_tags(version, platform, release, architecture):
    """List Docker tags for the given image."""
    if not version[:1].isdigit():
        click.echo("-".join((version, platform, release, architecture)))
        return

    version = Version.parse(version)
    image = Image.load(version, platform, release, architecture, versions.load())

    for tag in image.tags:
        click.echo(tag)
