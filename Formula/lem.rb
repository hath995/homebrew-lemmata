# Homebrew formula for lem — the verified Dafny package manager.
#
# This copy in the source repo is the SOURCE-OF-TRUTH template; the live formula
# lives in the tap repo hath995/homebrew-lemmata as Formula/lem.rb. Stamp + push it
# with deploy/cli/bump-brew.ps1 -Version <v> after building the macOS tarballs
# (deploy/cli/build-cli-macos.sh for BOTH arches) and uploading them to the release.
#
# Install:  brew tap hath995/lemmata && brew install lem
#
# NOTE: the sha256 values below are placeholders (all-zero) until the first macOS
# release; bump-brew.ps1 fills them from the built tarballs' checksums.
class Lem < Formula
  desc "Verified package manager for Dafny (bundles its own pinned Dafny+Z3)"
  homepage "https://lemmata.sh"
  version "0.1.21"
  # Proprietary/closed-source: the binary bundle is redistributable but the source
  # is not open, and Homebrew has no SPDX identifier for that.
  license :cannot_represent

  on_arm do
    url "https://github.com/hath995/lemmata-releases/releases/download/v0.1.21/lem-0.1.21-osx-arm64.tar.gz"
    sha256 "37454a5f5dc0596378ac01cf6ab873301b4dc1579ae668b715cb1fb4b403a00b"
  end

  on_intel do
    url "https://github.com/hath995/lemmata-releases/releases/download/v0.1.21/lem-0.1.21-osx-x64.tar.gz"
    sha256 "fb074ac779b11ed2904154c3a93de369d78f850bb179f3a495b533f3c83dc59b"
  end

  livecheck do
    url "https://github.com/hath995/lemmata-releases"
    strategy :github_latest
  end

  def install
    # The asset is a self-contained .NET app folder that carries its own pinned
    # Dafny+Z3 under ./dafny; keep it intact in libexec and expose only the
    # launcher. The apphost resolves its DLLs relative to the real (deref'd)
    # binary path, so a bin symlink into libexec works.
    libexec.install Dir["*"]
    (libexec/"lem").chmod 0755
    (libexec/"dafny/dafny").chmod 0755 if (libexec/"dafny/dafny").exist?
    bin.install_symlink libexec/"lem"
  end

  def caveats
    <<~EOS
      lem carries its own pinned Dafny+Z3 under its install dir and uses it
      internally; your PATH and any other Dafny install are left untouched.
      Set LEM_DAFNY to override. Run `lem doctor` to confirm the toolchain.
    EOS
  end

  test do
    assert_match "lem #{version}", shell_output("#{bin}/lem version")
  end
end
