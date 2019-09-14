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
old=1.8.1
new=2.0.0
sed -i "/BUILDBOT_VERSION/s/$old/$new/" Makefile
sed -i "/VERSION = (BUILDBOT_VERSION)/s/-[0-9]*/-1/"
sed -i "s/buildbot-$old/buildbot-$new/" README.md
make prepare
git commit -am "Upgrade to buildbot $new"
git push
```

## Releasing

```shell
version=2.0.0-1
$EDITOR CHANGELOG.md
git commit -am "Bump version to $version"
git tag -am "Bump version to $version" v$version
git push
git push --tags
github-release $version
```

See [github-release](https://github.com/cjolowicz/scripts/blob/master/github/github-release.sh).
