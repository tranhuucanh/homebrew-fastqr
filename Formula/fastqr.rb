class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.24/fastqr-1.0.24.tar.gz"
  sha256 "42337c6aace6ef0b8e20e2d4dd1f9687135a39727c931c714508ddca47b29e01"
  license "LGPL-2.1"
  version "1.0.24"

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
