# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Changed
- Upgrade Capybara to 3.30.0

## 1.1.1 - 2021-10-05
### Added
- Add release-* GH Actions

## 1.1.0 - 2020-02-17
### Changed
- Makefile clean target also removes Gemfile.lock file

### Fixed
- Fixed outdated Gemfile.lock file

## 1.0.0 - 2019-08-27
### Added
- Check invalidate cache response against 403 and 404 [#1]

## 0.10.2 - 2019-05-18
### Fixed
- Fix frozen string literal Rubocop violations

## 0.10.1 - 2018-10-10
### Changed
- Lock down InSpec to version 1.51.6 for consistency with other profiles

## 0.10.0 - 2018-05-20
### Added
- Introduce dependencies bundle vendoring

## 0.9.0 - 2017-10-15
### Added
- Initial version
