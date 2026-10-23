# Homebrew formula for the Vobiz CLI. The release workflow fills in the version, URLs and sha256 values
# (scripts/update-homebrew-formula.mjs) and opens a pull request with this file to vobiz-ai/homebrew-tap
# as Formula/vobiz.rb. Install: brew install vobiz-ai/tap/vobiz
class Vobiz < Formula
  desc "Official Vobiz CLI: voice calls, SMS, phone numbers, SIP trunks and VobizXML"
  homepage "https://www.vobiz.ai/docs/resources/cli"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.1/vobiz-0.1.1-darwin-arm64.tar.gz"
      sha256 "ed7962ce6620c1dc3888f215dce1ff16809fbf78dddb5684c2438f1978948a3c"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.1/vobiz-0.1.1-darwin-x64.tar.gz"
      sha256 "9086f43a9904e1d045b5c37f96f841e27a4948ceee14c47d95ac7816cea2b392"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.1/vobiz-0.1.1-linux-arm64.tar.gz"
      sha256 "d1def16811d73d9485ae9f17c8b1657fa19d42dfd29829a1fb6f70eeb1c7d68c"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.1/vobiz-0.1.1-linux-x64.tar.gz"
      sha256 "75c5a04c0c873fe68719cc7d843fd8ad34919ef47ff7d3309540f43f19831a97"
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
