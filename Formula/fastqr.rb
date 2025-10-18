class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  version "1.0.1"
  license "LGPL-2.1"

  on_arm do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.1/fastqr-1.0.1-macos-arm64.tar.gz"
    sha256 "1b7d408066d5e0e2f231b90c61d1581f89c2ab6cddf5b9b76a23b96c478a34b0"
  end

  on_intel do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.1/fastqr-1.0.1-macos-x86_64.tar.gz"
    sha256 "8d18b3617fbc52aa19a8cca196d9fe7bee2ed58a60ce6ebace0d24c7fa0aaf47"
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

