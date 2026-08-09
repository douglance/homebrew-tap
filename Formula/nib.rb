class Nib < Formula
  desc "Generate UI images from prompts for AI agents"
  homepage "https://github.com/douglance/nib"
  version "0.3.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/douglance/nib/releases/download/v0.3.1/nib-macos-aarch64.tar.gz"
      sha256 "a762cbf6563e880f7cdfadee5b6f097a3f01759a6f304b58d6ace07851ca0828"
    end

    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.3.1/nib-macos-x86_64.tar.gz"
      sha256 "5bfaccb8ed78f2607c284cc1e6f0c5b4a269d8fe49dd292a3b8fa10e935be0b6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.3.1/nib-linux-x86_64.tar.gz"
      sha256 "bbd59613d13a947c0028785b6f67deed68ff62fba445d2a85aec0caace86d393"
    end
  end

  def install
    bin.install "nib"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nib --version")
  end
end
