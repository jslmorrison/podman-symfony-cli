
# symfony-cli (container)

Lightweight container image that ships the Symfony CLI tool on top of PHP 8.4 (alpine). This image is intended for local development tasks that need the `symfony` binary.

This repository contains a `Containerfile` which builds an image with:

- Base: `php:8.4-cli-alpine`
- Composer copied from the official Composer image
- `install-php-extensions` helper and extensions: `intl`, `pdo_mysql`, `zip`
- Tools: `bash`, `curl`, `git`
- Symfony CLI installed from the official Cloudsmith repository

## Quick start

**N.B** If using `docker` and not `podman` - swap `podman` for `docker` in following commands.

Build the image locally (from the repository root where the `Containerfile` lives):

```sh
podman build -t symfony-cli:local .
```

Run the container to show the Symfony version / help output:

```sh
podman run --rm symfony-cli symfony help
```

Example: create a new Symfony project in the current directory using the CLI inside the container

```sh
podman run --rm -it -v "$(pwd):/app:Z" -v ${HOME}/.gitconfig:/root/.gitconfig:Z symfony-cli symfony local:new my-symfony-proj
```

## Notes and considerations

- Composer is installed and available as `/usr/bin/composer`. The image sets `COMPOSER_ALLOW_SUPERUSER=1` to allow Composer to run as root inside containers.
- The image installs `pdo_mysql` and `intl` PHP extensions as common defaults; add or remove extensions in the `Containerfile` if your project needs change.

## Rebuild and update

- To update Composer or the base PHP image, edit the `Containerfile` and rebuild.
- The Symfony CLI is installed from Cloudsmith at build time; when upstream releases a new package the next rebuild will pick it up.

