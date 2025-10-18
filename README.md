# Homebrew FastQR

Official Homebrew tap for [FastQR](https://github.com/tranhuucanh/fastqr) - a lightning-fast QR code generator.

## Installation

```bash
brew tap tranhuucanh/fastqr
brew install fastqr
```

## Usage

```bash
# Generate QR code
fastqr -d "Hello World" -o output.png

# With customization
fastqr -d "https://example.com" -o qr.png -s 500 -c "#FF0000" -b "#FFFFFF"

# With logo
fastqr -d "My Brand" -o branded.png -l logo.png
```

## Features

- ⚡ Lightning-fast QR code generation
- 🎨 Custom colors (foreground & background)
- 🖼️ Logo embedding support
- 📏 Adjustable size
- 🔧 Simple CLI interface

## Links

- **Source Code:** https://github.com/tranhuucanh/fastqr
- **Issues:** https://github.com/tranhuucanh/fastqr/issues
- **Documentation:** https://github.com/tranhuucanh/fastqr#readme

