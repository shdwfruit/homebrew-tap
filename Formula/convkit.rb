class Convkit < Formula
  desc "One command for everyday file conversion, offline"
  homepage "https://github.com/shdwfruit/convkit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.2.0/convkit-aarch64-apple-darwin.tar.xz"
      sha256 "4ec652627fba3a596593fdcb85d42f845390c7e45423d39a62421124e25c7a0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.2.0/convkit-x86_64-apple-darwin.tar.xz"
      sha256 "f8bd50422e17cb2188ac7f140b4617432356d86886408b5ec111b8272c200280"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.2.0/convkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff3fdd17779a80432d6b1f775dd640c04dc81b90925c612b28966f6809e0d444"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.2.0/convkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "53a7ae44b93df95e0b06a828418470964d6c5f6d0e211602d387ca8159e59041"
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
