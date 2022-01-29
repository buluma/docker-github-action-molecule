# GitHub molecule actions container

A container that is used for [GitHub actions molecule](https://github.com/marketplace/actions/molecule-action).

[![github-action-molecule build status](https://img.shields.io/docker/cloud/build/buluma/github-action-molecule.svg)](https://hub.docker.com/repository/docker/buluma/github-action-molecule) 
![Docker Pulls](https://img.shields.io/docker/pulls/buluma/docker-github-action-molecule)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/buluma/docker-github-action-molecule) 
![GitHub Release Date](https://img.shields.io/github/release-date/buluma/docker-github-action-molecule) 
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/buluma/docker-github-action-molecule/main)

This container contains:
- [docker](https://www.docker.com/) - Used by molecule to start instances using the `docker` driver.
- [git](https://git-scm.com/) - Used to pull data from a repository.
- [molecule](https://molecule.readthedocs.io/en/latest/) version 3.x.x - Used to orchestrate the tests.
- [tox](https://tox.readthedocs.io/en/latest/) - Used to test multiple version of ansible if `tox.ini` exists.

The default behaviour is to:
- See if `tox.ini` exists -> Run `tox`
- Otherwise -> Run `molecule test`
- Retry either (`tox` or `molecule`) 3 times.
- Run `test` if `command` is not set.
- Test the `default` scenario if `scenario` in not set.

Read how to [test locally](TESTING.md).
