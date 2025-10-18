class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  version "1.0.4"
  license "LGPL-2.1"

  on_arm do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.2/fastqr-1.0.4-macos-arm64.tar.gz"
    sha256 "790c071f3bcfeee4c5baeb1a9d451763148a8f93f7e67fb877348624c5eca29f"
  end

  on_intel do
    url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.2/fastqr-1.0.4-macos-x86_64.tar.gz"
    sha256 "12a9969e225e22018e17bed67de588764b2d098929437200de8f099cf42fb1f5"
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

