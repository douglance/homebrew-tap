class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "7975d7d5e504e43281afd32125ae582b9c1e1202ed2bfe2097aefaceb9e7c103"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "27b34d3b0f4e2d2d62e46ac68614eb1c299998f80f08cd51a78f2132ea8ccba5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92a4616a2b3047fd7d0e136d2641edb8d633a47246b31c080ef8b3e853ea248f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "516a702919013739b49af05b2f0d0608b3c4f2f52638c454fb0cf8748bec1549"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
