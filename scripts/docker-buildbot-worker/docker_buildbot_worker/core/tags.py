import attr

from .versions import Version


@attr.s(frozen=True)
class Tag:
    """Tag for a buildbot-worker Docker image."""

    version = attr.ib(default=None)
    platform = attr.ib(default=None)
    release = attr.ib(default=None)
    architecture = attr.ib(default=None)

    @version.validator
    def validate_version(self, attribute, value):
        if not value:
            assert (
                self.platform is None
                and self.release is None
                and self.architecture is None
            )

    @platform.validator
    def validate_platform(self, attribute, value):
        if not value:
            assert self.release is None and self.architecture is None

    @release.validator
    def validate_release(self, attribute, value):
        if not value:
            assert self.architecture is None

    def __str__(self):
        """Convert the tag to a string."""
        if not self.version:
            return "latest"

        version = Version.format(self.version)

        if not self.platform:
            return version

        if not self.release:
            return "-".join((version, self.platform))

        if not self.architecture:
            return "-".join((version, self.platform, self.release))

        return "-".join((version, self.platform, self.release, self.architecture))
