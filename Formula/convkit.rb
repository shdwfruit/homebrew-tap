class Convkit < Formula
  desc "One command for everyday file conversion, offline"
  homepage "https://github.com/shdwfruit/convkit"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.5.0/convkit-aarch64-apple-darwin.tar.xz"
      sha256 "c1dcc6844225b4f5365f0cb1d16bcccc3070f0ed47019fc91b9edab912b45917"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.5.0/convkit-x86_64-apple-darwin.tar.xz"
      sha256 "b3adb6000c5dee84606f091a14c89f61f0a5360279b4f4cd18dbebdc3d4aad3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.5.0/convkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a155de6529b7e4daa538643341e38c7b0272a29962cd8e93548dbb2aa9a2531b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shdwfruit/convkit/releases/download/v0.5.0/convkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a76d3d564d69edfacb69f7950b7ce1ea5b01a7b73d9b8d6c32022c264f8c358d"
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
