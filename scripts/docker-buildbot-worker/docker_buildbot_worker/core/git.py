import os

import requests

from .utils import listify, run


_REPOSITORY = "cjolowicz/docker-buildbot-worker"


@listify
def _get_git_tags_from_github_api(repository):
    """Retrieve the Git tags for the specified repository from the GitHub API."""
    response = requests.get(f"https://api.github.com/repos/{repository}/tags")
    response.raise_for_status()
    for tag in response.json():
        yield tag["name"]


def tags():
    """Return the Git tags."""
    if os.environ.get("TRAVIS_BRANCH"):
        return _get_git_tags_from_github_api(_REPOSITORY)
    return run("git", "tag").stdout.split()


def readfile(filename, ref="HEAD"):
    """Return the contents of the given file."""
    return run("git", "show", f"{ref}:{filename}").stdout


def root():
    """Return the repository root directory."""
    return run("git", "rev-parse", "--show-toplevel").stdout.strip()


def get_github_blob_url(filename, ref="master"):
    """Return the GitHub URL for the given file."""
    return "/".join(("https://github.com", _REPOSITORY, "blob", ref, filename))
