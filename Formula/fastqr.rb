class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  version "1.0.2"
  license "LGPL-2.1"

  on_arm do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.2/fastqr-1.0.2-macos-arm64.tar.gz"
    sha256 "d686665ee4d054003fb1cfe2f84bfe2e473d2cffe21c3ca58118b066616ec1d3"
  end

  on_intel do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.2/fastqr-1.0.2-macos-x86_64.tar.gz"
    sha256 "7f9f4eb9cb31c622788aadff30b5c5b089c2c810ab0b59f07ad56b1219091d10"
  end

  depends_on "vips"
  depends_on "glib"
  depends_on "gettext"

  def install
    # Homebrew auto-strips single top-level directory from tarball
    # So files are directly in buildpath: bin/, lib/, include/

    # Install library first
    lib.install "lib/libfastqr.dylib"
    # Create version symlink
    ln_s lib/"libfastqr.dylib", lib/"libfastqr.1.dylib"

    # Install binary
    bin.install "bin/fastqr"

    # Install headers
    include.install "include/fastqr.h" if File.exist?("include/fastqr.h")

    # Fix rpath to use installed library (after files are installed)
    system "install_name_tool", "-change", "@rpath/libfastqr.1.dylib",
           "#{lib}/libfastqr.1.dylib", bin/"fastqr"
  end

  test do
    # Test CLI
    system "#{bin}/fastqr", "--version"
    system "#{bin}/fastqr", "Hello Homebrew", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end

