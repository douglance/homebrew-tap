class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "c22f21e15455cf265f3acbb6c7fb493f4189ef95cb7fd5fda7ec097e4ac71b20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "532d9f9fb6e24e2d9f1aeba8429db5366aa43eae846661f40c8298e3406a8ed1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "73a0b00e1f6d55935e1e24fa2e46894db90e6f6faf231af8bdbd78538ce215ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.4.0/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "91b42377dfc0398e815c7d639428aa0fa7a227f1a94dc435449f7bbafb75a971"
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
    bin.install "vcsql" if OS.mac? && Hardware::CPU.arm?
    bin.install "vcsql" if OS.mac? && Hardware::CPU.intel?
    bin.install "vcsql" if OS.linux? && Hardware::CPU.arm?
    bin.install "vcsql" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
