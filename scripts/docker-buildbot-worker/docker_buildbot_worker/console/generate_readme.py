from collections import defaultdict
import os

import attr
import click

from ..core import images, git, markdown as md, versions
from ..core.versions import Version
from ..core.utils import lines


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
    if architecture is None or architecture == images.default.architecture:
        return rep
    return f"{rep} ({architecture})"


def _format_image(image, predicate=None):
    """Return a human-readable representation of the image.

    If specified, predicate is used to filter the image tags.
    """
    tags = image.tags if predicate is None else filter(predicate, image.tags)
    text = ", ".join(md.pre(tag) for tag in tags)
    dest = _to_dockerfile_url(image)
    return md.item(md.link(text, dest))


def _dict4(sequence):
    """Return a four-dimensional dict."""
    result = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))
    for (key1, key2, key3, key4), value in sequence:
        result[key1][key2][key3][key4] = value
    return result


class _Variables:
    """Bind variables for substitution in README.md."""

    variables = (
        "latest_upstream_version",
        "default_image_list",
        "platform_table",
        "default_platform_list",
        "full_image_list",
    )

    def __init__(self, versions, images):
        """Constructor"""
        self.versions = sorted(versions, reverse=True)
        self.architectures = sorted(
            set(image.architecture for image in images), reverse=True
        )

        self.platforms = sorted(set(image.platform for image in images))

        def by_release(platform):
            def key(release):
                if (platform, release) == ("opensuse", "42"):
                    return "14"
                return release

            return key

        self.releases = dict(
            (
                platform,
                sorted(
                    set(
                        image.release for image in images if image.platform == platform
                    ),
                    key=by_release(platform),
                    reverse=True,
                ),
            )
            for platform in self.platforms
        )

        self.images = _dict4(
            ((image.architecture, image.platform, image.release, image.version), image)
            for image in images
        )

    def get(self):
        """Return the variable bindings."""
        return dict((variable, getattr(self, variable)) for variable in self.variables)

    @property
    def latest_upstream_version(self):
        """Return the latest upstream version."""
        version = Version.canonical(self.versions)
        return Version.format(version.upstream)

    @property
    @lines
    def default_image_list(self):
        """Render the list of default images."""
        d = images.default
        by_version = self.images[d.architecture][d.platform][d.release]
        for version in self.versions:
            image = by_version.get(version)
            if image:
                yield _format_image(image, predicate=lambda tag: "-" not in tag)

    def _format_releases(self, architecture, platform):
        releases = [
            release
            for release in self.releases[platform]
            if release in self.images[architecture][platform]
        ]

        if not releases:
            return ""

        def item(release, first=False):
            text = _format_platform(platform, release) if first else release
            name = _format_platform(platform, release, architecture)
            return md.link(text, md.anchor(name))

        head = item(releases[0], first=True)
        tail = [item(release) for release in releases[1:]]
        return " · ".join([head] + tail)

    @property
    @lines
    def platform_table(self):
        """Render the table of available platforms."""

        yield from md.table(
            [[md.pre(architecture) for architecture in self.architectures]]
            + [
                [
                    self._format_releases(architecture, platform)
                    for architecture in self.architectures
                ]
                for platform in self.platforms
            ]
        )

    @property
    @lines
    def default_platform_list(self):
        """Render the list of platforms, each with its latest supported release."""
        for platform in sorted(self.images[images.default.architecture]):
            release = images.default_release(platform)
            name = _format_platform(platform, release)
            image = f"{_REPOSITORY}:<version>-{platform}"
            link = md.link(md.pre(image), md.anchor(name))
            yield md.item(f"{link} ({name})")

    @property
    @lines
    def full_image_list(self):
        """Render the full list of available images."""
        for architecture in self.architectures:
            yield md.item(md.link(_format_architecture(architecture)))

        for architecture in self.architectures:
            yield ""
            yield md.header(_format_architecture(architecture), 3)
            yield ""
            yield "Supported platforms:"
            yield ""

            for platform in self.platforms:
                releases = self._format_releases(architecture, platform)
                if releases:
                    yield md.item(releases)

            for platform in self.platforms:
                for release in self.releases[platform]:
                    images = self.images[architecture][platform][release]
                    if not images:
                        continue

                    yield ""
                    yield md.header(
                        _format_platform(platform, release, architecture), 4
                    )
                    yield ""

                    for version in self.versions:
                        image = images.get(version)
                        if image:
                            yield _format_image(
                                image,
                                predicate=lambda tag: not tag.startswith(str(version)),
                            )


def _write_readme(variables):
    """Write README.md, using README.md.in as a template.

    Substitute the given variables in the template.
    """
    basedir = git.root()
    sourcepath = os.path.join(basedir, "README.md.in")
    destpath = os.path.join(basedir, "README.md")
    with open(sourcepath) as source:
        with open(destpath, "w") as destination:
            contents = source.read()
            contents = contents.format(**variables)
            destination.write(contents)


@click.command()
def generate_readme():
    """Generate README.md from README.md.in."""
    versions_ = versions.load(canonical=True)
    images_ = images.load(versions_)
    variables = _Variables(versions_, images_)
    _write_readme(variables.get())
