class Convkit < Formula
  desc "One command for everyday file conversion, offline"
  homepage "https://github.com/shdwfruit/convkit"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.3.1/convkit-aarch64-apple-darwin.tar.xz"
      sha256 "6a156164a9874b18c283db65f7f77f66fb104bd708611f1be7a74000036fc8d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.3.1/convkit-x86_64-apple-darwin.tar.xz"
      sha256 "7d3abff32fbb9889fda808c7b3fa6935b6050f977bbb522341cfc4b57869673c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.3.1/convkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "314c63aa62ead2d9762eb93850eb66e5094ba5ff48270926800a4b97c1d31cd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.3.1/convkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65a32ef72dcf0fed449dc568b516f319b383307b85bc9294712e34aa156a5d70"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "conv"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "conv"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "conv"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "conv"
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
