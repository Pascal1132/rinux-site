# Rinux Site

This repository (`rinux-site`) publishes the Rinux website and package registry.

- **Landing page**: `https://rinux.pascalparent.ca/`
- **Registry**: `https://rinux.pascalparent.ca/packages/registry.json`

## Layout

```
CNAME                            → custom domain for GitHub Pages
.github/workflows/
  deploy-pages.yml               → deploys site to GitHub Pages on push main
  refresh-release.yml            → pulls latest Rinux release metadata into packages/release.json
                                   (triggered by repository_dispatch from Rinux build-iso.yml,
                                    daily cron as safety net, and workflow_dispatch)
packages/
  index.html                     → landing page (promoted to site root on deploy)
  registry.json                  → registry consumed by rpkg
  release.json                   → latest ISO release metadata (auto-refreshed, read by landing JS)
  pkgs/*.tar                     → package archives downloaded by rpkg install
  _config.yml                    → GitHub Pages config (unused with static deploy)
  README.md                      → rpkg integration docs
```

The `packages/` directory is the web root. On deploy, `index.html` is promoted
to the site root so the landing page is served at `/` while the registry,
release metadata, and archives remain under `/packages/`.

## Release integration

The landing page's Download section reads `/packages/release.json`, which is
refreshed by `refresh-release.yml` from the latest GitHub Release of
`Pascal1132/Rinux`. The stable ISO download link is
`https://github.com/Pascal1132/Rinux/releases/latest/download/rinux-latest.iso`,
produced by the Rinux `build-iso.yml` workflow on every non-prerelease tag.

To trigger an immediate refresh, run the `Refresh Rinux release metadata`
workflow manually from the Actions tab, or have the Rinux repo fire a
`rinux-release` dispatch event (requires a PAT stored as `SITE_DISPATCH_TOKEN`
in the Rinux repository secrets).

## Local changes

Update files in `packages/`, then push `main` to trigger Pages deployment.