import attr

from .versions import Version


@attr.s(frozen=True)
class Image:
    """A Docker image for buildbot-worker."""

    version = attr.ib(factory=Version)
    platform = attr.ib(default="alpine")
    release = attr.ib(default="")
    architecture = attr.ib(default="x86_64")


default = Image()


def release_key(platform):
    """Return a key function to sort releases."""

    def key(release):
        if (platform, release) == ("opensuse", "42"):
            return (14,)
        return tuple(map(int, release.split(".")))

    return key
