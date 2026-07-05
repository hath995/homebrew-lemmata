# homebrew-lemmata

A [Homebrew](https://brew.sh) tap for **lem** — the verified package manager for
[Dafny](https://dafny.org). `lem` ships as a self-contained bundle that carries its
own pinned Dafny + Z3, so you need neither .NET nor Dafny installed.

```sh
brew tap hath995/lemmata
brew install lem
```

Then:

```sh
lem doctor     # confirm the bundled toolchain resolved
lem --help
```

Homepage: <https://lemmata.sh> · Release assets:
<https://github.com/hath995/lemmata-releases>

> **Status:** the macOS release assets are being finalized. Until the first macOS
> build lands, `Formula/lem.rb` may not be installable yet. Windows users can install
> today via Scoop: `scoop bucket add lemmata https://github.com/hath995/scoop-lemmata; scoop install lem`.

The formula is generated from the source repo (`deploy/cli/bump-brew.ps1`); please
don't hand-edit `Formula/lem.rb` here.
