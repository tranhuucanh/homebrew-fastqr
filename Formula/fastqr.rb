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

  depends_on "vips"
  depends_on "glib"
  depends_on "gettext"

  def install
    # Extract the right platform directory
    platform = Hardware::CPU.arm? ? "macos-arm64" : "macos-x86_64"

    # Install library first
    lib.install "#{platform}/lib/libfastqr.dylib"
    # Create version symlink
    ln_s lib/"libfastqr.dylib", lib/"libfastqr.1.dylib"

    # Install binary
    bin.install "#{platform}/bin/fastqr"

    # Fix rpath to use installed library
    system "install_name_tool", "-change", "@rpath/libfastqr.1.dylib",
           "#{lib}/libfastqr.1.dylib", bin/"fastqr"

    # Install headers
    include.install "#{platform}/include/fastqr.h" if File.exist?("#{platform}/include/fastqr.h")
  end

  test do
    # Test CLI
    system "#{bin}/fastqr", "--version"
    system "#{bin}/fastqr", "Hello Homebrew", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end

