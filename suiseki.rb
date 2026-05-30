class Suiseki < Formula
  desc "Terminal renderer for diffs and code"
  homepage "https://github.com/michaeldlfx/suiseki"
  version "1.0.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.3/suiseki-darwin-arm64"
      sha256 "ef7aa30e23599259c1fc3546f90ee2dfc3fe830e47afd2e860cc832d1f21b768"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.3/suiseki-darwin-x64"
      sha256 "4f96a505985a48532aa1bbf906847ed0ac3f7fb6866635d42e6da48478ab619e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.3/suiseki-linux-arm64"
      sha256 "52033fb5ae0efb85b9063ebb0e64a58382cc374c9264ecfaf649c3621d7bacec"
    end
    on_intel do
      url "https://github.com/michaeldlfx/suiseki/releases/download/v1.0.3/suiseki-linux-x64"
      sha256 "b04676c3df61a52504d3c89187bd3e7b82a30ed13264230a43805c04b6196b7b"
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
