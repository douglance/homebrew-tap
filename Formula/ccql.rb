class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "a8e99d130ed99ce04c9946847227e5c95f8d24a795a3e3355449e6711c8732f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "e5f9f660e5e6142f73d6eca98284e1e38101cb36abb196154a6505d30e466aa5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "623fe91722fe36fafb2daf55f7efc0f2ceef30fdc07898a1638f36e8ff95e773"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "62e8c1e0655913e22ea5426cd7e6fb2e9ac8398e14394f8341e309fe8ff3d5ff"
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
    bin.install "ccql" if OS.mac? && Hardware::CPU.arm?
    bin.install "ccql" if OS.mac? && Hardware::CPU.intel?
    bin.install "ccql" if OS.linux? && Hardware::CPU.arm?
    bin.install "ccql" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
