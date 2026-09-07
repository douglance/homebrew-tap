class Devsql < Formula
  desc "Code Mode across AI coding history, shell history, Git, source code, and worklogs"
  homepage "https://github.com/douglance/devsql"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "806fa60cb86f4ce6e587ed3997deb08f4cc1411871ca24a28f2e0d1fd7960f6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "e4600de5e2168ca3dcab051a89b5aa24fdc67c334868566fd994fa1b2db20d88"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b01a94105275b05981a2d660c5fcc6558b1200724eaf940cd4856f14e8fbb61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d680eb841b4cdfcc27f5190d70c901bf19b14aea3a4221fe61a020ac487427d"
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
