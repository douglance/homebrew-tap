class Nib < Formula
  desc "Screenshot annotation tool for AI-human visual collaboration"
  homepage "https://github.com/douglance/nib"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/nib/releases/download/v0.1.0/nib-aarch64-apple-darwin.tar.xz"
      sha256 "eb41b6254a6780f6a9b58e3135e174579fc32bb51624005efcc7a515eaad568c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nib"
    end

    install_binary_aliases!

    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
