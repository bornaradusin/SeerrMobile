# SeerrMobile

The [Seerr mobile app](https://github.com/seerr-team/mobile-app), for Android (phones, tablets and
TV boxes) and iPhone/iPad, with what it doesn't have yet. Seerr is the media request app for
Jellyfin, Plex and Emby.

SeerrMobile follows the original: every day it checks for a new release of the original app, builds
it with SeerrMobile's changes and releases it here. It installs next to the official app (its own
app ID), and updates itself.

## What it adds

- **Manage a movie or series** (the gear on its page, for admins), as Seerr's web app does: its
  requests (delete them), **remove it from Radarr or Sonarr** with its files, **mark it
  available**, and **clear its data**.
- **Request actions** on the requests list: approve, decline, edit, retry, **delete**, **cancel**
  your own pending request, and remove from Radarr/Sonarr.
- **Updates from inside the app**: about once a day, and from the menu (Check for updates), it looks
  here for a newer version. On Android it downloads and installs it (the download is deleted once
  the update is in); on an iPhone it hands it to AltStore or SideStore.

## Installing

From [Releases](https://github.com/bornaradusin/SeerrMobile/releases/latest):

- **Android**: download `SeerrMobile-….apk` on the phone (or TV box) and open it. Allow installing
  from your browser or file manager if asked.
- **iPhone and iPad**: `SeerrMobile-….ipa` isn't signed: install it with
  [AltStore](https://altstore.io), [SideStore](https://sidestore.io) or
  [Sideloadly](https://sideloadly.io), which sign it with your own Apple ID. With a free Apple ID
  it has to be refreshed every 7 days (AltStore and SideStore do it for you).

## Versions

The original's version plus SeerrMobile's own number: **0.11.2.1** is the first SeerrMobile release
of the original's 0.11.2, 0.11.2.2 the next (a change to SeerrMobile's patches).

## How it's made

This repository holds only SeerrMobile's changes, as patches on the original
(`patches/`), and the build (`.github/workflows/build.yml`):

1. `tools/apply.sh [tag]` takes the original app at a release (default: its newest) and applies the
   patches with `git am --3way`.
2. GitHub builds the APK (signed with SeerrMobile's key, from the repository's secrets) and the IPA,
   and releases them.

Changing SeerrMobile: run `tools/apply.sh`, change the app in `app/` and commit there, then
`tools/save.sh` writes the patches again. If a new release of the original changes something a
patch touches, the daily build fails (GitHub emails about it) until the patch is updated.

## Credits

The app is the work of the [Seerr team](https://github.com/seerr-team) (MIT licence, see
`LICENSE`). SeerrMobile is an independent version made by
[bornaradusin](https://github.com/bornaradusin); it isn't made by, or connected with, the Seerr
project.
