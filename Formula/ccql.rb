class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/ccql"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/ccql/releases/download/v0.1.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "9f66fa0e9fcf215ec4ce21b4ff9f599e4fd2f29a88bbd917e7804b3364335d94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/ccql/releases/download/v0.1.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "ad08981d0cc6efa0e0f8c3605ddd751c96c2000f85307fc8640a86bea3ad3953"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/ccql/releases/download/v0.1.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a1f78eb5788ddcd4d52e58574ff14386d9026233318298be2ff2c0ded8e8843"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/ccql/releases/download/v0.1.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bfdfdb0e27f052e28e9731e2ae8a17030b1d9c5d5536b388477ab588c4ebd4a7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
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
      bin.install "ccql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ccql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ccql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ccql"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
