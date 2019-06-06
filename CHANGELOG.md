# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.3.1-5] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 8 (i386).

## [2.3.1-4] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 7 (i386).

## [2.3.1-3] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 6 (i386).

## [2.3.1-2] - 2019-06-06
### Fixed
- Fix cryptography installation on CentOS 6.

## [2.3.1-1] - 2019-06-06
### Changed
- Upgrade to buildbot 2.3.1.

## [2.3.0-1] - 2019-06-06
### Changed
- Upgrade to buildbot 2.3.0.

## [2.2.0-3] - 2019-06-06
### Fixed
- Fix cryptography installation on CentOS 5.

## [2.2.0-2] - 2019-04-25
### Changed
- Switch Debian 7 images to archive.debian.org.

## [2.2.0-1] - 2019-04-25
### Changed
- Upgrade to buildbot 2.2.0.

## [2.1.0-2] - 2019-04-05
### Added
- Add OpenSUSE 15 (x86_64).

## [2.1.0-1] - 2019-04-05
### Changed
- Upgrade to buildbot 2.1.0.

## [2.0.1-1] - 2019-04-05
### Changed
- Upgrade to buildbot 2.0.1.

## [2.0.0-1] - 2019-04-05
### Changed
- Upgrade to buildbot 2.0.0.

## [1.8.2-6] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 8 (i386).

## [1.8.2-5] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 7 (i386).

## [1.8.2-4] - 2019-06-06
### Fixed
- Fix cryptography installation on Debian 6 (i386).

## [1.8.2-3] - 2019-06-06
### Fixed
- Fix cryptography installation on CentOS 6.

## [1.8.2-2] - 2019-06-06
### Fixed
- Fix cryptography installation on CentOS 5.

## [1.8.2-1] - 2019-06-05
### Changed
- Upgrade to buildbot 1.8.2.

## [1.8.1-3] - 2019-04-25
### Changed
- Switch Debian 7 images to archive.debian.org.

## [1.8.1-2] - 2019-04-05
### Fixed
- CI: Fix name of image pulled for the build cache.

## [1.8.1-1] - 2019-04-05
### Changed
- Upgrade to buildbot 1.8.1.

## [1.8.0-2] - 2019-04-05
### Fixed
- Fix build failure for Scientific 7 due to `python3` and `pip3`
  symlinks now being provided by the upstream Python 3.6 packages.

## 1.8.0-1 - 2019-04-03
### Added
- Initial version: buildbot 1.8.0
- Supported architectures:
  - x86_64
  - i386
- Supported platforms:
  - Alpine 3.9
  - CentOS 5
  - CentOS 6
  - CentOS 7\*
  - Debian 5 (lenny)\*
  - Debian 6 (squeeze)
  - Debian 7 (wheezy)
  - Debian 8 (jessie)
  - Debian 9 (stretch)
  - OpenSUSE 13\*
  - OpenSUSE 42\*
  - Scientific 6\*
  - Scientific 7\*
  - Ubuntu 12.04 (precise)
  - Ubuntu 14.04 (trusty)
  - Ubuntu 16.04 (xenial)
  - Ubuntu 18.04 (bionic)
- \*) x86_64 only

[Unreleased]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.1-5...HEAD
[2.3.1-5]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.1-4...v2.3.1-5
[2.3.1-4]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.1-3...v2.3.1-4
[2.3.1-3]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.1-2...v2.3.1-3
[2.3.1-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.1-1...v2.3.1-2
[2.3.1-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.3.0-1...v2.3.1-1
[2.3.0-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.2.0-3...v2.3.0-1
[2.2.0-3]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.2.0-2...v2.2.0-3
[2.2.0-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.2.0-1...v2.2.0-2
[2.2.0-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.1.0-2...v2.2.0-1
[2.1.0-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.1.0-1...v2.1.0-2
[2.1.0-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.0.1-1...v2.1.0-1
[2.0.1-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v2.0.0-1...v2.0.1-1
[2.0.0-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.1-3...v2.0.0-1
[1.8.2-6]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.2-5...v1.8.2-6
[1.8.2-5]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.2-4...v1.8.2-5
[1.8.2-4]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.2-3...v1.8.2-4
[1.8.2-3]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.2-2...v1.8.2-3
[1.8.2-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.2-1...v1.8.2-2
[1.8.2-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.1-3...v1.8.2-1
[1.8.1-3]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.1-2...v1.8.1-3
[1.8.1-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.1-1...v1.8.1-2
[1.8.1-1]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.0-2...v1.8.1-1
[1.8.0-2]: https://github.com/cjolowicz/docker-buildbot-worker/compare/v1.8.0-1...v1.8.0-2
