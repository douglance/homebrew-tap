class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "143e07585f74a93af2c060582dd14e8fa50a40c0820c6d9fcd08abac2fab8ddd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "de80493823e8b01a87c51e6bbd06b5b20ab9f0a93351cbf4f63ce90fb5f926b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d405ccb63939fff878427021d1d2953de6a72796c5964d38a8f99a91606d5b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1625dd76fcb9c684fc3a297f2298956b3ff7e085bfe28e1c9296ee01dca1574a"
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
