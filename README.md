# homebrew-suiseki

This is the [Homebrew](https://brew.sh/) tap for [suiseki](https://github.com/michaeldlfx/suiseki), a terminal renderer for diffs and code. Use it to install suiseki on macOS and Linux with Homebrew.

## Install

```bash
brew install michaeldlfx/suiseki/suiseki
```

That is shorthand for tapping first, then installing:

```bash
brew tap michaeldlfx/suiseki
brew install suiseki
```

For a specific version, browse the [releases](https://github.com/michaeldlfx/suiseki/releases) and install the binary directly, or use the [install script](https://github.com/michaeldlfx/suiseki#install-prebuilt-binary) with `SUISEKI_VERSION` set.

## Upgrade

```bash
brew upgrade suiseki
```

(`suiseki upgrade` also self-updates a binary installed outside Homebrew, but for a Homebrew install prefer `brew upgrade`.)

## Uninstall

```bash
brew uninstall suiseki
brew untap michaeldlfx/suiseki
```

## Maintenance

The `suiseki.rb` formula is generated from a published suiseki release (its version and per-platform `checksums.txt`) and committed by the `update-formula` workflow in this repo. Run it after a new suiseki release:

```bash
gh workflow run update-formula --repo michaeldlfx/homebrew-suiseki
```
