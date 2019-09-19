from . import git, locations
from .images import Image, default
from .index import Index
from .tags import Tag
from .versions import Version
from .utils import dictify, listify, setify, memoize


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
    prefixes = f"{variable} = ", f"export {variable} = "
    for line in lines:
        for prefix in prefixes:
            if line.startswith(prefix):
                return line[len(prefix) :]


class Builder:
    def __init__(self, include_worktree=False):
        self.include_worktree = include_worktree

    @dictify
    def build(self):
        for image in self.images:
            yield image, self.tags(image)

    @property
    def versions(self):
        if self.include_worktree:
            return self._tagged_versions | {self._worktree_version}

        return self._tagged_versions

    @property
    @memoize()
    @setify
    def _tagged_versions(self):
        """Return the available versions, as marked by Git tags."""
        for tag in git.tags():
            if tag.startswith("v"):
                yield Version.parse(tag[1:])

    @property
    @memoize()
    def _worktree_version(self):
        lines = open(locations.makefile).read().splitlines()
        upstream = _lookup_variable_definition("BUILDBOT_VERSION", lines)
        version = _lookup_variable_definition("VERSION", lines)
        version = version.replace("$(BUILDBOT_VERSION)", upstream)
        return Version.parse(version)

    @property
    def images(self):
        if self.include_worktree:
            return self._tagged_images | self._worktree_images
        return self._tagged_images

    @property
    @memoize()
    @setify
    def _tagged_images(self):
        for version in self._tagged_versions:
            contents = git.readfile("Makefile", ref=f"v{version}")
            yield from self._load_images(version, contents)

    @property
    @memoize()
    @setify
    def _worktree_images(self):
        with open(locations.makefile) as makefile:
            return self._load_images(self._worktree_version, makefile.read())

    def _load_images(self, version, contents):
        lines = _resolve_line_continuations(contents.splitlines())
        directories = _lookup_variable_definition("DIRS", lines).split()

        for directory in directories:
            platform, release, architecture = directory.split("/")
            yield Image(version, platform, release, architecture)

    @property
    @memoize()
    def index(self):
        return Index(self.images)

    @listify
    def tags(self, image):
        """Return the Docker tags for a given image."""
        for version in image.version.prefixes():
            if not image.version.is_canonical(self.versions, version):
                continue

            if version:
                yield Tag(version, image.platform, image.release, image.architecture)

            if image.architecture != default.architecture:
                continue

            if version:
                yield Tag(version, image.platform, image.release)

            if image.release != self.index.latest_release(
                image.platform, image.version, image.architecture
            ):
                continue

            if version:
                yield Tag(version, image.platform)

            if image.platform != default.platform:
                continue

            yield Tag(version)
