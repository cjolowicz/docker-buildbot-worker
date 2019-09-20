import click

from ..core import git, locations, markdown as md
from ..core.utils import lines
from ..core.images import default
from ..core.database import Database


_REPOSITORY = "cjolowicz/buildbot-worker"
_PLATFORMS = {
    "alpine": "Alpine",
    "centos": "CentOS",
    "debian": "Debian",
    "opensuse": "OpenSUSE",
    "ubuntu": "Ubuntu",
    "scientific": "Scientific Linux",
}


def _to_dockerfile_url(image):
    """Return the URL of the Dockerfile for a given Docker image."""
    path = "/".join((image.platform, image.release, image.architecture, "Dockerfile"))
    return git.get_github_blob_url(path, ref=f"v{image.version}")


def _format_architecture(architecture):
    """Return a human-readable representation of the architecture."""
    return f"{architecture} architecture"


def _format_platform(platform, release, architecture=None):
    """Return a human-readable representation of the platform."""
    rep = f"{_PLATFORMS[platform]} {release}"
    if architecture is None or architecture == default.architecture:
        return rep
    return f"{rep} ({architecture})"


def _format_releases(platform, releases, architecture):
    def item(release, first=False):
        text = _format_platform(platform, release) if first else release
        name = _format_platform(platform, release, architecture)
        return md.link(text, md.anchor(name))

    head = item(releases[0], first=True)
    tail = [item(release) for release in releases[1:]]
    return " · ".join([head] + tail)


def _format_image(image, tags):
    """Return a human-readable representation of the image."""
    text = ", ".join(md.pre(tag) for tag in tags)
    dest = _to_dockerfile_url(image)
    return md.item(md.link(text, dest))


class _Variables:
    """Bind variables for substitution in README.md."""

    variables = (
        "latest_upstream_version",
        "default_image_list",
        "platform_table",
        "default_platform_list",
        "full_image_list",
    )

    def __init__(self, database):
        """Constructor"""
        self.database = database

    def get(self):
        """Return the variable bindings."""
        return dict((variable, getattr(self, variable)) for variable in self.variables)

    @property
    def latest_upstream_version(self):
        """Return the latest upstream version."""
        return self.database.latest_upstream_version

    @property
    @lines
    def default_image_list(self):
        """Render the list of default images."""
        for version in self.database.versions:
            release = self.database.latest_release(
                default.platform, version=version, architecture=default.architecture
            )

            if not release:
                continue

            image = self.database.get(
                version=version,
                platform=default.platform,
                release=release,
                architecture=default.architecture,
            )

            if not image:
                continue

            tags = [
                tag
                for tag in self.database.tags(image)
                if not any(
                    (len(tag.version) == 4, tag.platform, tag.release, tag.architecture)
                )
            ]

            yield _format_image(image, tags)

    def _release_list(self, architecture, platform):
        releases = [
            release
            for release in self.database.releases(platform)
            if self.database.has(
                platform=platform, release=release, architecture=architecture
            )
        ]

        return _format_releases(platform, releases, architecture) if releases else ""

    @property
    @lines
    def platform_table(self):
        """Render the table of available platforms."""

        yield from md.table(
            [[md.pre(architecture) for architecture in self.database.architectures]]
            + [
                [
                    self._release_list(architecture, platform)
                    for architecture in self.database.architectures
                ]
                for platform in self.database.platforms
            ]
        )

    @property
    @lines
    def default_platform_list(self):
        """Render the list of platforms, each with its latest supported release."""
        for platform in self.database.platforms:
            if self.database.has(platform=platform, architecture=default.architecture):
                release = self.database.latest_release(
                    platform, architecture=default.architecture
                )
                name = _format_platform(platform, release)
                image = f"{_REPOSITORY}:<version>-{platform}"
                link = md.link(md.pre(image), md.anchor(name))
                yield md.item(f"{link} ({name})")

    @property
    @lines
    def full_image_list(self):
        """Render the full list of available images."""
        for architecture in self.database.architectures:
            yield md.item(md.link(_format_architecture(architecture)))

        for architecture in self.database.architectures:
            yield ""
            yield md.header(_format_architecture(architecture), 3)
            yield ""
            yield "Supported platforms:"
            yield ""

            for platform in self.database.platforms:
                releases = self._release_list(architecture, platform)
                if releases:
                    yield md.item(releases)

            for platform in self.database.platforms:
                for release in self.database.releases(platform):
                    if not self.database.has(
                        architecture=architecture, platform=platform, release=release
                    ):
                        continue

                    yield ""
                    yield md.header(
                        _format_platform(platform, release, architecture), 4
                    )
                    yield ""

                    for version in self.database.versions:
                        image = self.database.get(
                            version=version,
                            architecture=architecture,
                            platform=platform,
                            release=release,
                        )
                        if not image:
                            continue

                        tags = [
                            tag
                            for tag in self.database.tags(image)
                            if len(tag.version) < 4
                        ]

                        yield _format_image(image, tags)


def _write_readme(variables):
    """Write README.md, using README.md.in as a template.

    Substitute the given variables in the template.
    """
    with open(locations.readme_template) as source:
        with open(locations.readme, "w") as destination:
            contents = source.read()
            contents = contents.format(**variables)
            destination.write(contents)


@click.command()
def write_readme():
    """Generate README.md."""
    database = Database.load()
    variables = _Variables(database)
    _write_readme(variables.get())
