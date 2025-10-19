class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  url "https://github.com/tranhuucanh/fastqr/releases/download/v1.0.2/fastqr-1.0.2.tar.gz"
  sha256 "305774ab967c0a5852d7683cbd341b39998397cf150ea0a0af70be3481918faa"
  license "LGPL-2.1"
  version "1.0.2"

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
