class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  version "1.0.0"
  license "LGPL-2.1"

  on_arm do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.0/fastqr-1.0.0-macos-arm64.tar.gz"
    sha256 "fa83d4a70a3a4c449598ec94171e61b9430d409407084a61810dea90328fef5b"
  end

  on_intel do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.0/fastqr-1.0.0-macos-x86_64.tar.gz"
    sha256 "cf799762eba8980358348ca45405ef10b7eed3fab9d7eca7d45dbd0330e2d718"
  end

  def install
    # Install pre-built binary
    bin.install "fastqr"

    # Install library if exists
    lib.install Dir["lib/*"] if Dir.exist?("lib")

    # Install headers if exists
    include.install Dir["include/*"] if Dir.exist?("include")
  end

  test do
    # Test CLI
    system "#{bin}/fastqr", "--version"
    system "#{bin}/fastqr", "-d", "Hello Homebrew", "-o", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end

