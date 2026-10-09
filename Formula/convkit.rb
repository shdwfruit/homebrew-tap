class Convkit < Formula
  desc "One command for everyday file conversion, offline"
  homepage "https://github.com/shdwfruit/convkit"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.4.0/convkit-aarch64-apple-darwin.tar.xz"
      sha256 "297367f63afffe0bca838c6cf14db5bff2a4e9aaa3f14fc9fd87615074dbf652"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.4.0/convkit-x86_64-apple-darwin.tar.xz"
      sha256 "b3d0d70e3436b014fc588263aad9812c954bce7ccaeafab62e4dff39f602753f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.4.0/convkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "82ccb4022609c51e7661c4a968e5dd01883f8ff4d631f1af360dd7e1e0734351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.4.0/convkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bbf28fc6b72df6e9e46ff9101e798f8c6b290621b38c6810d817c19efaeeccf"
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
