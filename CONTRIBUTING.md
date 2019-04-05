# Contributing

## Upgrading upstream

```shell
old=1.8.1
new=2.0.0
sed -i "s/$old-[0-9]*/$new-1/" Makefile
sed -i "s/$old/$new/" common/buildbot.m4
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