class Ccql < Formula
  # Reconciled by the v0.3.2 release workflow.
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "fb51d384cdcdd11dcc52b7095e61ac7eee8eaa4bef6f96494d0a9401d2c2f21a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "d9a60df27bdd149af34d470f6a9618a715e560160e921656d8f599fbef15b670"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "203c5131d73b240eaf79bd139c3c8204ac9c37eb3b57e3cbbec15da10594846f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "15a8045597c04c94a95b08e28fbd0ec4b2353b62318c3511499f5121f5e170c4"
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
