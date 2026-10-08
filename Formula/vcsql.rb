class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "269472ce17b650074e16dd678f3673f7c1e459142dbe9b15ca83ea2d69877c8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "6f84350533b602d83b721269ebdf211e255a369826b5cfe07d7acaa19f618ea5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b9a769f14e3a7bc5e0ceacbe5409ef8c76999d292587e7e2a87c3746b6fe3d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f130ade2e4e9fae5db4c7bcf194c64423442bcec7baf5bc1bba280a127b0e7a9"
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
