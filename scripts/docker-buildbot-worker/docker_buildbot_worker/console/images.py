import click

from ..core.database import Database
from ..core.versions import Version


@click.command()
@click.option("-v", "--version", help="buildbot version")
@click.option("-p", "--platform", help="platform name")
@click.option("-r", "--release", help="platform release")
@click.option("-a", "--architecture", help="architecture")
def images(version, platform, release, architecture):
    """List Docker images."""
    if version is not None:
        version = Version.parse(version)

    database = Database.load()
    images = database.find(
        version=version, platform=platform, release=release, architecture=architecture
    )

    for image in sorted(images, reverse=True):
        click.echo(
            f"{image.version} {image.platform} {image.release} {image.architecture}"
        )
