class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  version "1.0.0"
  license "LGPL-2.1"

  on_arm do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.0/fastqr-1.0.0-macos-arm64.tar.gz"
    sha256 "4930fbee1fd75f17ed03f989e47115a4ffde2a7c5d07764272eee231a68bd7ad"
  end

  on_intel do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.0/fastqr-1.0.0-macos-x86_64.tar.gz"
    sha256 "988903004a99a9e2c989bfe27c62b1e969d7a8a9e0b4e9209e193822af427978"
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

