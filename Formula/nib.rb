class Nib < Formula
  desc "Screenshot annotation tool for AI-human visual collaboration"
  homepage "https://github.com/douglance/nib"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/douglance/nib/releases/download/v0.3.0/nib-macos-aarch64.tar.gz"
      sha256 "526fd365b4733cace80eca9ff598a4fa7862037abb7600b8a28a34c8be27059b"
    end

    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.3.0/nib-macos-x86_64.tar.gz"
      sha256 "1614524ea0c568c68226527ee56a53da65d6ba661b6cc5f8df07cd5f9f0eef24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/douglance/nib/releases/download/v0.3.0/nib-linux-x86_64.tar.gz"
      sha256 "b8296c1efdb7168e5ebb56b8740ebff294cf6698e408a9cd0f5f7c2132a1b6ec"
    end
  end

  def install
    bin.install "nib"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nib --version")
  end
end
