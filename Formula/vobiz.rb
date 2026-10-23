# Homebrew formula for the Vobiz CLI. The release workflow fills in the version, URLs and sha256 values
# (scripts/update-homebrew-formula.mjs) and opens a pull request with this file to vobiz-ai/homebrew-tap
# as Formula/vobiz.rb. Install: brew install vobiz-ai/tap/vobiz
class Vobiz < Formula
  desc "Official Vobiz CLI: voice calls, SMS, phone numbers, SIP trunks and VobizXML"
  homepage "https://www.vobiz.ai/docs/resources/cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.0/vobiz-0.1.0-darwin-arm64.tar.gz"
      sha256 "833793dc7fe6765c4e870feb298fc547e2686a5a66bcaea282ec8f3ec72698f6"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.0/vobiz-0.1.0-darwin-x64.tar.gz"
      sha256 "2bb05396b534fcbd4a1631c920bbcb59c2ffc8bb6e1e9b2ec83b09bb126f5a54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.0/vobiz-0.1.0-linux-arm64.tar.gz"
      sha256 "b6b878b2339bb34f4075aeb3083d66c9b8b0a1088dcf8b4b43d54cd913b4858d"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.0/vobiz-0.1.0-linux-x64.tar.gz"
      sha256 "dbeeb2f5635887855e1ab801953f01f924e095b343f3a18238c0b22748c54e89"
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
