class Devsql < Formula
  desc "Code Mode across AI coding history, shell history, Git, source code, and worklogs"
  homepage "https://github.com/douglance/devsql"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "3175d445a7dac11e8f5c95e39fa9ae4d119c0bcca56b89c784343d589384ded3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "4244830dfb29053c1427be34a012feec596c29b5c9f61fc3c7e524859f34015e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8f3a97f1bc8dac0613bd161f848d8c08038901bc3965c28ebf435ebeb0783979"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff90b1920e70ae45466f9f26df7aab88e4c52f2204d96e1683a61d3091c0c1b5"
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
