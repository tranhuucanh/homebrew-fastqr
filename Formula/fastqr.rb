class Fastqr < Formula
  desc "Lightning-fast QR code generator with advanced features"
  homepage "https://github.com/tranhuucanh/fastqr"
  url "https://github.com/tranhuucanh/fastqr/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "7a3ad4b61e8ea66f147568056a2490f4cf6e6dc167e542658c850656ccb8183c"
  license "LGPL-2.1"
  version "1.0.0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qrencode"
  depends_on "vips"

  def install
    # Build the library and CLI
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Test CLI
    system "#{bin}/fastqr", "--version"
    system "#{bin}/fastqr", "-d", "Hello Homebrew", "-o", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end

