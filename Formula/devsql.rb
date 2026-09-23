class Devsql < Formula
  desc "Code Mode across AI coding history, shell history, Git, source code, and worklogs"
  homepage "https://github.com/douglance/devsql"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/devsql-aarch64-apple-darwin.tar.xz"
      sha256 "ecf69384a4256d70bf82ab5f2ab3892cfdf4c15e7c48124bf25bd5fc91d425ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/devsql-x86_64-apple-darwin.tar.xz"
      sha256 "061be01557b02e89314c02186166c7a4927a5bf331b1735bccc7988ed5fefef1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/devsql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1078e4020520ef2ae2bec1f2d4c3f9ff5790be0059ea7de1210a75381122ed59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.6.0/devsql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "160038578144b1de0c5a1cad32d654e3d59ddf779377efcb98974d7fbcfc1a58"
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
