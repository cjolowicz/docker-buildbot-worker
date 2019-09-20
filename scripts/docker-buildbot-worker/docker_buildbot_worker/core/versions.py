import attr

from .utils import listify


@attr.s(frozen=True)
class Version:
    """A version number of the form 1.0.0-1."""

    major = attr.ib(default=0)
    minor = attr.ib(default=0)
    patch = attr.ib(default=0)
    downstream = attr.ib(default=0)

    @classmethod
    def parse(cls, rep):
        """Parse the version from a string."""
        upstream, downstream = rep.split("-", 1)
        major, minor, patch = map(int, upstream.split("."))
        downstream = int(downstream)
        return cls(major, minor, patch, downstream)

    def __str__(self):
        """Convert the version to a string."""
        return f"{self.major}.{self.minor}.{self.patch}-{self.downstream}"

    @staticmethod
    def format(parts):
        """Convert the version-tuple to a string."""
        if len(parts) < 4:
            return ".".join(str(part) for part in parts)
        return str(Version(*parts))

    @property
    def upstream(self):
        """Return the upstream version."""
        return self.major, self.minor, self.patch

    def to_tuple(self):
        """Return the version as a tuple."""
        return self.major, self.minor, self.patch, self.downstream

    def startswith(self, prefix):
        """Return true if the initial version components are equal to the prefix."""
        return prefix == self.to_tuple()[: len(prefix)]

    @listify
    def prefixes(self):
        """Return all prefixes of the version."""
        parts = self.to_tuple()
        while parts:
            yield parts
            parts = parts[:-1]
        yield parts

    @staticmethod
    def canonical(versions, prefix=()):
        """Find the greatest version with the given prefix."""
        return max(version for version in versions if version.startswith(prefix))

    def is_canonical(self, versions, prefix=None):
        if prefix is None:
            prefix = self.upstream
        return self == Version.canonical(versions, prefix=prefix)
