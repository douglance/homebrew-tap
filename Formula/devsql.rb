class Devsql < Formula
  desc "Code Mode across AI coding history, shell history, Git, source code, and worklogs"
  homepage "https://github.com/douglance/devsql"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "bb2526d9138ae20a0c3c26858040f7841afc6b4a82c0af44e142bf2f19dd60a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "5a7cceb19e05fee265ac0e6c1a604ff09da0e9bbc03f27ff5e651e979ebf299f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9b4774825c96aef831a36d1c51a3590626d31e33666aa3997ea418f6edc8fde9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a2550283a96a9bbb4b25a6673c23afe52df3b48b9b780d7ce881cee303e4d5f8"
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
