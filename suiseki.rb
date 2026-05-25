class Suiseki < Formula
  desc "Terminal renderer for diffs and code"
  homepage "https://github.com/michaeldlfx/suiseki"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.1/suiseki-darwin-arm64"
      sha256 "99f68893827515ef9709f787f90aee6a992741bd8ca51390213279695c650610"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.1/suiseki-darwin-x64"
      sha256 "55deca8eaf7499adff7407a5d87262fc3d7b3df73f23f7c027f33822e27b67ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.1/suiseki-linux-arm64"
      sha256 "eb25af204d6469c4cae79a2e1dacd222c57cb39727957e1f483d207902f364a5"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.1/suiseki-linux-x64"
      sha256 "5fbb07f35859dd6dfe54768295f2eea8baf8a20c8f3879df74e2cf066180ad6b"
    end
  end

  def install
    bin.install Dir["suiseki-*"].first => "suiseki"
    # `sat` is the same binary under a second name: invoked as `sat` it runs as
    # `suiseki view` (a cat/bat/tree alternative). Relative symlink within bin.
    bin.install_symlink "suiseki" => "sat"
  end

  test do
    assert_match "suiseki #{version}", shell_output("#{bin}/suiseki --version")
    assert_match "suiseki #{version}", shell_output("#{bin}/sat --version")
  end
end
