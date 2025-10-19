class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.13/fastqr-1.0.13.tar.gz"
  sha256 "a8f60ef10ee2b69669c7abc5bcefda181c8762d56b40196aa056215a4e451210"
  license "LGPL-2.1"
  version "1.0.13"

  depends_on "cmake" => :build
  depends_on "qrencode"
  depends_on "libpng"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_INSTALL_PREFIX=#{prefix}",
           "-DFASTQR_BUILD_EXAMPLES=OFF",
           *std_cmake_args
    system "cmake", "--build", "build", "-j#{ENV.make_jobs}"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/fastqr", "--version"
    system "#{bin}/fastqr", "Hello Homebrew", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end
