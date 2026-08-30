class Convkit < Formula
  desc "One command for everyday file conversion, offline"
  homepage "https://github.com/shdwfruit/convkit"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.1.0/convkit-aarch64-apple-darwin.tar.xz"
      sha256 "a053e4c9b9c214aed074ad922e61490b65e7c4bfe923952285469cf92fe4f74f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.1.0/convkit-x86_64-apple-darwin.tar.xz"
      sha256 "c015c077fc2dc747f8aa5d1488b2e599eb24d831ebb55a439f597f9d5fdf02b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.1.0/convkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d12ebb93c7640f79260c38d26647b877ba3c041650b191bde716bc2a45eede7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.1.0/convkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e979c97866166ecac7537c6a2bda79025e06513f28d05be1d52b938ad9ef0ef6"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
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
