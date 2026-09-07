class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "f6a509848312f6e8ef4bbc4ddb3e18c303b1c62a2b08dcddebbf824dcf8a67de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "9b125c57d545746df7777415e0436b24006632f1480d24b4c974c4ee066b8e38"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "798dfbe011ee4acabe00486ca5d909108f39f5bf8d136d32eb8f9cba40966c0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.5.0/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01df6f1c422e959eb3f2d2f18435abd0db5a74571d5ed56a8c838436547c231f"
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
