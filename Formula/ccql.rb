class Ccql < Formula
  desc "Claude Code Query Language - SQL query engine for Claude Code data"
  homepage "https://github.com/douglance/devsql"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/ccql-aarch64-apple-darwin.tar.xz"
      sha256 "ffa4f369303689d947fe6fa38a33bd5bfbf700685e5798e4a99f633483dcd8a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/ccql-x86_64-apple-darwin.tar.xz"
      sha256 "305d72bba0d7df8c7f695e22f4f210549088e25278ac52107cfb985d0ab9646d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/ccql-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6b776f0e2262cb968b9ae502f7f0ce539db63fbb67560d7fc1cc02469eab0852"
    end
    if Hardware::CPU.intel?
      url "https://github.com/douglance/devsql/releases/download/v0.3.0/ccql-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0ddfb22371918b937991bc0de69aa73503991ff296a7e19b23562bf83bbe2b07"
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
      bin.install "ccql"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ccql"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ccql"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ccql"
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
