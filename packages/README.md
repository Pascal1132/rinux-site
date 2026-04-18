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