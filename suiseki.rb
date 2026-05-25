class Suiseki < Formula
  desc "Terminal renderer for diffs and code"
  homepage "https://github.com/michaeldlfx/suiseki"
  version "1.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.2/suiseki-darwin-arm64"
      sha256 "0a985f794a20077e2db9c7fd621b645e161e6ec793ae5ec3eb628cea688640c4"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.2/suiseki-darwin-x64"
      sha256 "12ef478f75126d53eccfab467e85454a0db1c6f78ab8f86a68c903844c1c1701"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.2/suiseki-linux-arm64"
      sha256 "3b148bfc77c50543015573af52c389be19f72200e91a6537b1ad8932cc1fdbbf"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.2/suiseki-linux-x64"
      sha256 "b58d1fba7e6191d5352769157886c3087520ad3b5a581a699d3f79741c5e40fe"
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
