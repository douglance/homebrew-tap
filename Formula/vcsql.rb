class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "3c95d810fa7c3ef1392f60232a68dbf8d4678ab29cc2d9c22d3777fe8fe0d0e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "8a674e5584bb6ff6584bc88c66d9ebc447881281a6880be1a7a743bae44a82d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "141e5f2c0d0402b11f4b6ee6a2b61582724703eae9b7c76e262ab6ebef8c02fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.1/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "77845ae98d39996b053366ea29fe1b10a099401a2abb61b326895f79cf4c3470"
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
      bin.install "vcsql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vcsql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vcsql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vcsql"
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
