# Rinux Package Registry

This repository serves as the official package registry for `rpkg`, the Rinux package manager.

## Registry URL

```
https://rinux.pascalparent.ca/packages/registry.json
```

## Adding a package

Add an entry to `registry.json`:
```json
{
  "name": "package-name",
  "version": "1.0.0",
  "url": "https://rinux.pascalparent.ca/packages/pkgs/package-name-1.0.0.tar",
  "sha256": "64-lowercase-hex-chars-of-the-.tar-archive"
}
```

Packages are `.tar` archives stored in `packages/pkgs/` and extracted into `/usr/bin/` on the target system. `rpkg` verifies the archive SHA-256 before extraction.

## Local development

For testing, point rpkg at a local registry:
```sh
rpkg --registry-url file:///path/to/test-registry.json install my-package
```

## DOOM package

The `doom` package is built from the pinned `doomgeneric-src` gitlink. It uses
the Rinux framebuffer backend and expects a legally obtained `DOOM.WAD` at
runtime. Sound and mouse input are not yet supported.

Build the package from the site repository root:

```sh
./packages/build-doom.sh
```

The script creates `packages/pkgs/doom-1.0.0.tar` and prints its SHA-256. The
registry entry must be reviewed and updated separately; package construction
does not silently rewrite `registry.json`.
