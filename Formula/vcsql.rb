class Vcsql < Formula
  desc "SQL query engine for Git repository data"
  homepage "https://github.com/douglance/devsql"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/vcsql-aarch64-apple-darwin.tar.xz"
      sha256 "36dd271296836f74986a36cae9126feb85c62aad7a63bf6c3a2c5b484654e494"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/vcsql-x86_64-apple-darwin.tar.xz"
      sha256 "4d277b5a144ec451e684f71f0c6769535f9b3634327912d81fad7af6d750f369"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/vcsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b556791a921e5ef09a5ec141d042b9f402e8674d7fef1995aa830f1679ee19d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.2/vcsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "463934a2b5190b148218542dd9395e3059162837d38b0aa6f6a3383b02e06b3b"
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
