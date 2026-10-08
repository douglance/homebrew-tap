class Devsql < Formula
  desc "Code Mode across AI coding history, shell history, Git, and source code"
  homepage "https://github.com/douglance/devsql"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "d5263a71bebb881c9001d8780236a7f6ad38b1322eea0af764c3653e65dfcb7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "d1bff74a9b85f7377d4761b94daaa01dfecc8306f33d98581c43a79b3accb202"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5676adef2ed1fb4558c277cdf032d9d2297c90f7a29bf51a3691eedc71836937"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.7.0/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbfd77f8438dcbca148935d371f760e4f5fdddfe61a0abb310e36d1638d833fb"
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
