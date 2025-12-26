class Devsql < Formula
  desc "Unified SQL queries across Claude Code + Git data"
  homepage "https://github.com/douglance/devsql"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "26f8fad9ebae82f60788512f19776cb02a77916c15b2a4382b0be25accd4aa02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "16fbd6acc350744d071dfb15ad5d6bbf6d8f96af980752bfe392fa29c2d611f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9cd67b536eb484d7634f269669ab8c1e54ea1eaf8ba6aa3234a30a653fdfaa56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "587f4d38bf99c4299683fd6026e3e359a6163a2b2464b51e1562071033987c12"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
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
      bin.install "devsql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "devsql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "devsql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "devsql"
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
