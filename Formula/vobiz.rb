# Template for the Vobiz CLI Homebrew formula. The version, URLs and all-zero sha256 values below are
# placeholders: for each stable release the release workflow fills them in (scripts/update-homebrew-formula.mjs)
# and opens a pull request to vobiz-ai/homebrew-tap. The live formula is Formula/vobiz.rb in that repository.
# Install: brew install vobiz-ai/tap/vobiz
class Vobiz < Formula
  desc "Official Vobiz CLI: voice calls, SMS, phone numbers, SIP trunks and VobizXML"
  homepage "https://www.vobiz.ai/docs/resources/cli"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.3/vobiz-0.1.3-darwin-arm64.tar.gz"
      sha256 "61be2345db5c29b554a1f41dd4849331fefcc5a27075c5ae9d21ff663280af90"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.3/vobiz-0.1.3-darwin-x64.tar.gz"
      sha256 "f9c9d24ddc0c0042bd8d556ed7611d21dda540f525ecdcd1f0e32d5c0c4774c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.3/vobiz-0.1.3-linux-arm64.tar.gz"
      sha256 "2fb49a65d424cb2a131402df971a7daa5705a9a17c9ee8580b05fc84d7582123"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.3/vobiz-0.1.3-linux-x64.tar.gz"
      sha256 "5be49f5346bb8a0bfd2b548339712ac795db4a646550ae4719a054b5e2b820da"
    end
  end

  def install
    bin.install "vobiz"
    bash_completion.install "completions/vobiz.bash" => "vobiz" if File.exist?("completions/vobiz.bash")
    zsh_completion.install "completions/_vobiz" if File.exist?("completions/_vobiz")
    fish_completion.install "completions/vobiz.fish" if File.exist?("completions/vobiz.fish")
    man1.install "man/vobiz.1" if File.exist?("man/vobiz.1")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vobiz --version")
    ENV["VOBIZ_CONFIG_DIR"] = testpath/"config"
    ENV["VOBIZ_NO_UPDATE_CHECK"] = "1"
    assert_match "vobiz", shell_output("#{bin}/vobiz --help")
  end
end
