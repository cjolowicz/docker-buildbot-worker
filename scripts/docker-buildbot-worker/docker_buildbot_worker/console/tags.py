import click

from ..core.database import Database
from ..core.versions import Version


@click.command()
@click.option("-v", "--version", help="buildbot version")
@click.option("-p", "--platform", help="platform name")
@click.option("-r", "--release", help="platform release")
@click.option("-a", "--architecture", help="architecture")
def tags(version, platform, release, architecture):
    """List Docker tags."""
    if version is not None:
        try:
            version = Version.parse(version)
        except ValueError:
            click.echo("-".join((version, platform, release, architecture)))
            return

    database = Database.load()

    for image in database.find(
        version=version, platform=platform, release=release, architecture=architecture
    ):
        for tag in database.tags(image):
            click.echo(str(tag))
