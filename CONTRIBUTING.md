# Contributing

## Building

Generating the Dockerfiles requires [GNU
make](https://www.gnu.org/software/make/) and the [GNU
m4](https://www.gnu.org/software/m4/) preprocessor.

Here is a list of available targets:

| Target         | Description                      |
| ---            | ---                              |
| `make build`   | Build the images.                |
| `make push`    | Upload the images to Docker Hub. |
| `make login`   | Log into Docker Hub.             |
| `make dep`     | Generate the dependency rules.   |
| `make prepare` | Generate the Dockerfiles.        |

Pass `NAMESPACE` to prefix the images with a Docker Hub repository name. The
default is `DOCKER_USERNAME`.

Pass `DIRS` to select individual images, e.g. `make DIRS=alpine/3.9/x86_64` to
only build the 64-bit image for Alpine 3.9.

The `login` target is provided for non-interactive use and looks for
`DOCKER_USERNAME` and `DOCKER_PASSWORD`.

## Upgrading upstream

```shell
upstream=2.4.1
downstream=1

git checkout -b upgrade
docker-buildbot-worker bumpversion $upstream-$downstream
make prepare
git commit --all --message="Upgrade to buildbot $upstream"

$EDITOR CHANGELOG.md
git commit --all --message="Update CHANGELOG.md"
```

## Releasing

```shell
docker-buildbot-worker write-json --include-worktree
git commit --all --message="Update images.json"

docker-buildbot-worker write-readme
git commit --all --message="Update README.md"

bumpversion-changelog $version
git commit --all --message="Update CHANGELOG.md"

git tag --message="docker-buildbot-worker $version" v$version
git push --follow-tags

github-release $version
```

For downstream releases, first bump the version:

```shell
version=$(docker-buildbot-worker bumpversion)
git commit --all --message="Bump version to $version"
```

The rest works like above.
