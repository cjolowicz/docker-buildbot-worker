from collections import defaultdict

from .images import release_key


class Index:
    def __init__(self, images=None):
        self.images = set()
        self.version = defaultdict(set)
        self.platform = defaultdict(set)
        self.release = defaultdict(set)
        self.architecture = defaultdict(set)

        if images:
            for image in images:
                self.add(image)

    def add(self, image):
        self.images.add(image)
        self.version[image.version].add(image)
        self.platform[image.platform].add(image)
        self.release[image.release].add(image)
        self.architecture[image.architecture].add(image)

    def find(self, *, version=None, platform=None, release=None, architecture=None):
        for image in self.images:
            if (
                (version is None or image in self.version[version])
                and (platform is None or image in self.platform[platform])
                and (release is None or image in self.release[release])
                and (architecture is None or image in self.architecture[architecture])
            ):
                yield image

    def latest_release(self, platform, version=None, architecture=None):
        """Return the latest platform release.

        When specified, return the latest release supported for the given version and
        architecture.
        """
        images = self.find(
            platform=platform, version=version, architecture=architecture
        )

        try:
            return max((image.release for image in images), key=release_key(platform))
        except ValueError:
            pass
