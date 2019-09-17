import attr

from . import git
from .utils import listify
from .versions import Version


_DEFAULT_ARCHITECTURE = "x86_64"
_DEFAULT_PLATFORM = "alpine"
_DEFAULT_RELEASES = {
    "alpine": "3.9",
    "centos": "7",
    "debian": "9",
    "opensuse": "15",
    "scientific": "7",
    "ubuntu": "18.04",
}


def default_release(platform):
    """Return the latest supported release for the platform."""
    return _DEFAULT_RELEASES[platform]


@attr.s
class Image:
    """A Docker image for buildbot-worker."""

    version = attr.ib(factory=Version)
    platform = attr.ib(default=_DEFAULT_PLATFORM)
    release = attr.ib()
    architecture = attr.ib(default=_DEFAULT_ARCHITECTURE)
    tags = attr.ib(factory=list)

    @release.default
    def default_release(self):
        """Return the latest supported release for the image platform."""
        return default_release(self.platform)

    @classmethod
    def load(cls, version, platform, release, architecture, versions):
        """Load the specified image."""
        tags = _get_tags(version, platform, release, architecture, versions)
        return cls(version, platform, release, architecture, tags)


default = Image()


def _resolve_line_continuations(lines):
    """Glue together lines terminated by a backslash."""
    previous = None

    for line in lines:
        if previous is not None:
            if previous.endswith("\\"):
                line = previous[:-1] + line
            else:
                yield previous

        previous = line

    if previous is not None:
        yield previous


def _lookup_variable_definition(variable, lines):
    """Return the right-hand side of a variable definition."""
    prefix = f"{variable} = "
    for line in lines:
        if line.startswith(prefix):
            return line[len(prefix) :]


def _get_tag_suffixes(platform, release, architecture):
    """Return the Docker tag suffixes for the given platform."""
    yield platform, release, architecture

    if architecture != default.architecture:
        return

    yield platform, release

    if release != default_release(platform):
        return

    yield (platform,)

    if platform != default.platform:
        return

    yield ()


@listify
def _get_tags(version, platform, release, architecture, versions):
    """Return the Docker tags for a given image."""
    for prefix in version.prefixes():
        if version.is_canonical(versions, prefix):
            for suffix in _get_tag_suffixes(platform, release, architecture):
                if prefix:
                    rep = Version.format(prefix)
                    yield "-".join((rep,) + suffix)
                elif not suffix:
                    yield "latest"


@listify
def load(versions):
    """Return the Docker images for the given versions."""
    for version in versions:
        output = git.readfile("Makefile", ref=f"v{version}")
        lines = _resolve_line_continuations(output.splitlines())
        directories = _lookup_variable_definition("DIRS", lines).split()

        for directory in directories:
            platform, release, architecture = directory.split("/")
            yield Image.load(version, platform, release, architecture, versions)
