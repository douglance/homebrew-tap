class Devsql < Formula
  # Reconciled by the v0.3.2 release workflow.
  desc "Unified SQL queries across Claude Code + Git data"
  homepage "https://github.com/douglance/devsql"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "eba771b99a70387b54e93b6580df533bd0f2c8ca086d2a7dc51c7b5b9f65b259"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "b7182a5d81b5a3e5a57aadd30c8fa4aa3befcfdd4a0d1f448f45bbd9827e0ed0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "775891dba54316dbf06df768231915bc9da3c6e938f225b0a05d69d37e58101d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56175bb4600c0810c091d5c567c3486131717fe8bfa0aeeccb14216eaaf79f8d"
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
    bin.install "devsql" if OS.mac? && Hardware::CPU.arm?
    bin.install "devsql" if OS.mac? && Hardware::CPU.intel?
    bin.install "devsql" if OS.linux? && Hardware::CPU.arm?
    bin.install "devsql" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
