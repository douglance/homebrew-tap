class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "28e4eb334ad7e707e79f128c6abe00a0bca5af36e6368b970f1dc9b8ffaa94ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "031c832034fcfd18754328631b96bcc181f864b940d6f8502440c101e4eec549"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "987813446d0c712c6fc0067420a07523844d550192ecf121515e21fdaf9b38cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.1.2/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6cd631df0a162d916b16aa37842c1b0eaadb3e47b694ce29035a307191d9562d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
