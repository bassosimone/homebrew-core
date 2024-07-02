require "language/node"

class Astgen < Formula
  desc "Generate AST in json format for JS/TS"
  homepage "https://github.com/joernio/astgen"
  url "https://github.com/joernio/astgen/archive/refs/tags/v3.16.0.tar.gz"
  sha256 "3097f0db0d7dc223c851ed42e2692d2991f36f0e4446321f5f4ef22413af696c"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, sonoma:         "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, ventura:        "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, monterey:       "3016bd27a2d0c2b01a6c2880072d2f7858826ac45efd23217627ccb0da9903b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8d037eaf6c46383213bfd3c9fbef70131db4ac0562da3957a446fca230958e4"
  end

  depends_on "node"

  uses_from_macos "zlib"

  def install
    # Disable custom postinstall script
    system "npm", "install", *Language::Node.std_npm_install_args(libexec), "--ignore-scripts"
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"main.js").write <<~EOS
      console.log("Hello, world!");
    EOS

    assert_match "Converted AST", shell_output("#{bin}/astgen -t js -i . -o #{testpath}/out")
    assert_match '"fullName": "main.js"', (testpath/"out/main.js.json").read
    assert_match '"0": "Console"', (testpath/"out/main.js.typemap").read
  end
end
