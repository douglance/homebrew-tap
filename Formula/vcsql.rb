class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "7fd7448bca648d2763b1bb875a3317d7d054f42093877c4c79a4f944c220a447"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "5faaa405a3714a0a32d6e582f570878756e8b6034061f7304b514b155ed78a1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0396a878f394361165aea74e2cf171995b41880eea9c1b33ab21857d423dd12a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e612fc40f42f8eaf240f459994c085f48f12c31ade5c70f30941c1c77fcca563"
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
