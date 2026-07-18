class Nib < Formula
  desc "Screenshot annotation tool for AI-human visual collaboration"
  homepage "https://github.com/douglance/nib"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/douglance/nib/releases/download/v0.2.3/nib-macos-aarch64.tar.gz"
      sha256 "274c716165a551ff26c427c06944b12ddbc30dab9c8840ba71b1ebdfd7537eb7"
    end

    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.2.3/nib-macos-x86_64.tar.gz"
      sha256 "e52b4c2a4c42c2d9fc176616631c75ddfff729abd3799c8185c232671ec1f140"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.2.3/nib-linux-x86_64.tar.gz"
      sha256 "eec6812434671e96af18b21e04fe5082db86005e82743e258b06f0f45ad1c6f2"
    end
  end

  def install
    bin.install "nib"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nib --version")
  end
end
