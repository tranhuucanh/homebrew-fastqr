class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.26/fastqr-1.0.26.tar.gz"
  sha256 "58c8381000710d1de19c587aae8b003127978e3c3f6025e0fdd6a1e84594f718"
  license "LGPL-2.1"
  version "1.0.26"

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
