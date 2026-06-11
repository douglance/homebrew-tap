class Devsql < Formula
  desc "Unified SQL queries across Claude Code + Git data"
  homepage "https://github.com/douglance/devsql"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "f259f902541d514472eea492da96b372aba88c86ec3c061a4d80c3d935120ecc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "6a6204dc804b9fe2c1c226f2f807f7627882598caf3889540e08ad9e50bb4c4a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "497fa2bac517eb6dfc7abe73cf6ca1430e39e9c7e8dc08dee6b253839f7f04f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f885cbe1e1ac72e93750fe535ee2679b103333dcb0911e96ebd7c9d22c8b366"
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
