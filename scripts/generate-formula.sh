#!/usr/bin/env sh
set -eu

# Generate the suiseki Homebrew formula from a published release.
#
# Usage: scripts/generate-formula.sh <tag> <checksums-file>
#   <tag>             release tag, e.g. v0.1.0
#   <checksums-file>  the release's checksums.txt (sha256 <two spaces> filename)
#
# Writes the formula to stdout.

TAG="$1"
CHECKSUMS="$2"
VERSION="${TAG#v}"
BASE="https://github.com/michaeldlfx/suiseki/releases/download/$TAG"

sha_for() {
  awk -v file="$1" '$2 == file {print $1}' "$CHECKSUMS"
}

# Homebrew on Linux targets glibc, so use the glibc linux binaries (not -musl).
darwin_arm="$(sha_for suiseki-darwin-arm64)"
darwin_x64="$(sha_for suiseki-darwin-x64)"
linux_arm="$(sha_for suiseki-linux-arm64)"
linux_x64="$(sha_for suiseki-linux-x64)"

for pair in \
  "suiseki-darwin-arm64:$darwin_arm" \
  "suiseki-darwin-x64:$darwin_x64" \
  "suiseki-linux-arm64:$linux_arm" \
  "suiseki-linux-x64:$linux_x64"; do
  if [ -z "${pair##*:}" ]; then
    echo "generate-formula.sh: missing checksum for ${pair%%:*}" >&2
    exit 1
  fi
done

cat <<EOF
class Suiseki < Formula
  desc "Terminal renderer for diffs and code"
  homepage "https://github.com/michaeldlfx/suiseki"
  version "$VERSION"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "$BASE/suiseki-darwin-arm64"
      sha256 "$darwin_arm"
    end
    on_intel do
      url "$BASE/suiseki-darwin-x64"
      sha256 "$darwin_x64"
    end
  end

  on_linux do
    on_arm do
      url "$BASE/suiseki-linux-arm64"
      sha256 "$linux_arm"
    end
    on_intel do
      url "$BASE/suiseki-linux-x64"
      sha256 "$linux_x64"
    end
  end

  def install
    bin.install Dir["suiseki-*"].first => "suiseki"
    # \`sat\` is the same binary under a second name: invoked as \`sat\` it runs as
    # \`suiseki view\` (a cat/bat/tree alternative). Relative symlink within bin.
    bin.install_symlink "suiseki" => "sat"
  end

  test do
    assert_match "suiseki #{version}", shell_output("#{bin}/suiseki --version")
    assert_match "suiseki #{version}", shell_output("#{bin}/sat --version")
  end
end
EOF
