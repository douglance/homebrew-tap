class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "e3acbc036428b0c88f935ca2cbe4fed3f273b83720884d73931f57f5c3cb1a2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "520954f615c5c18708f964cb99dc7f41e5e076baaeb6f9e8e77f0ab8eb51bf16"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1df2451c1e686354b977fba98447088c14d2b77b7fa51358f41aa5e8d1d99344"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4c42c1ed2be7f418d5c623a2a2d7374c11af4c66c057b41fdb4c8461f121d5d"
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
