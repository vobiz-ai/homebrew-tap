# Homebrew formula for the Vobiz CLI. The release workflow fills in the version, URLs and sha256 values
# (scripts/update-homebrew-formula.mjs) and opens a pull request with this file to vobiz-ai/homebrew-tap
# as Formula/vobiz.rb. Install: brew install vobiz-ai/tap/vobiz
class Vobiz < Formula
  desc "Official Vobiz CLI: voice calls, SMS, phone numbers, SIP trunks and VobizXML"
  homepage "https://www.vobiz.ai/docs/resources/cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.2/vobiz-0.1.2-darwin-arm64.tar.gz"
      sha256 "a13206a1c1e32b60ad913bc69bd3328c4266c925db362820d14ba600bca41c47"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.2/vobiz-0.1.2-darwin-x64.tar.gz"
      sha256 "476f0f5e0d75d9589162178f547a7a85bea4709f1b92bcf533979337ec5a7410"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.2/vobiz-0.1.2-linux-arm64.tar.gz"
      sha256 "2a5ecc2fe8e5f55edcca6660860b6a046bcdf37631f494c9f4bf539e78dede2c"
    end
    on_intel do
      url "https://github.com/vobiz-ai/Vobiz-CLI/releases/download/v0.1.2/vobiz-0.1.2-linux-x64.tar.gz"
      sha256 "e266c73703c18ca43f7f8fa3cfe1369cd914d7cd35eaf913b8254d54ea940d8c"
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
