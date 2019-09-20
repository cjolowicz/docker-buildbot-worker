import json

import attr

from . import locations
from .builder import Builder
from .images import Image, default, release_key
from .index import Index
from .tags import Tag
from .utils import listify, memoize, dictify
from .versions import Version


@dictify
def _from_json(data):
    for item in data:
        version = Version(**item["image"].pop("version"))
        image = Image(version=version, **item["image"])
        tags = [Tag(**tag) for tag in item["tags"]]
        yield image, tags


@listify
def _to_json(data):
    for image, tags in data.items():
        image = attr.asdict(image)
        tags = [attr.asdict(tag) for tag in tags]
        yield dict(image=image, tags=tags)


class Backend:
    def __init__(self, data):
        self.data = data

    @classmethod
    def build(cls, **kwargs):
        builder = Builder(**kwargs)
        data = builder.build()
        return cls(data)

    @classmethod
    def load(cls):
        with open(locations.images) as fp:
            data = json.load(fp)
        return cls(_from_json(data))

    def save(self):
        data = _to_json(self.data)
        with open(locations.images, "w") as fp:
            json.dump(data, fp, indent=2)


class Database:
    def __init__(self, backend):
        self.backend = backend

    @classmethod
    def load(cls):
        backend = Backend.load()
        return cls(backend)

    @classmethod
    def build(cls, **kwargs):
        backend = Backend.build(**kwargs)
        return cls(backend)

    def tags(self, image):
        return self.backend.data[image]

    @property
    @memoize()
    def versions(self):
        versions = set(image.version for image in self.backend.data.keys())
        versions = [version for version in versions if version.is_canonical(versions)]
        versions.sort(reverse=True)
        return versions

    @property
    @memoize()
    def index(self):
        images = self.backend.data.keys()
        return Index((image for image in images if image.version in self.versions))

    @property
    @memoize()
    def platforms(self):
        return sorted(set(image.platform for image in self.index.images))

    @property
    @memoize()
    def architectures(self):
        def key(architecture):
            return "" if architecture == default.architecture else architecture

        return sorted(set(image.architecture for image in self.index.images), key=key)

    def releases(self, platform):
        return self._releases[platform]

    @property
    @memoize()
    @dictify
    def _releases(self):
        for platform in self.platforms:
            releases = set(image.release for image in self.find(platform=platform))
            releases = sorted(releases, key=release_key(platform), reverse=True)
            yield platform, releases

    def latest_release(self, *args, **kwargs):
        return self.index.latest_release(*args, **kwargs)

    @listify
    def find(self, **kwargs):
        return self.index.find(**kwargs)

    def get(self, **kwargs):
        for image in self.index.find(**kwargs):
            return image

    def has(self, **kwargs):
        return self.get(**kwargs) is not None

    @property
    @memoize()
    def latest_upstream_version(self):
        """Return the latest upstream version."""
        version = Version.canonical(self.versions)
        return Version.format(version.upstream)
