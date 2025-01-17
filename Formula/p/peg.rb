class Peg < Formula
  desc "Program to perform pattern matching on text"
  homepage "https://www.piumarta.com/software/peg/"
  url "https://www.piumarta.com/software/peg/peg-0.1.18.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/p/peg/peg_0.1.18.orig.tar.gz"
  sha256 "20193bdd673fc7487a38937e297fff08aa73751b633a086ac28c3b34890f9084"
  license "MIT"

  # The homepage links to development tarballs using the stable version format
  # (with nothing in the file name to distinguish stable/development), so we
  # check the "current stable version is 1.2.3" text.
  livecheck do
    url :homepage
    regex(/current\s+stable\s+version\s+is\s+v?(\d+(?:\.\d+)+)/im)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e99a54fba2ae0361a0cc96006004934ab1f9ecc66878d5382fe3d9e1f3ec5fd0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f19c265ab4e83b4ac64c6d37e15227a23f199986185d447860580bce9354cda6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ab5b7c51553751ef8e97394ebd30d901df33e46c5f2c6bf4b38f966673ce1932"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1b9a4c3a056a8c36357592bec0a6b3f72d8741f6b2dad69e68d3653799628012"
    sha256 cellar: :any_skip_relocation, sonoma:         "f314576dadc0cc498d787e142af59c2d9754a7f229425fff4a36bd102e9fa7e7"
    sha256 cellar: :any_skip_relocation, ventura:        "070085f152f57fecc73b066cfd8d5118f133b4f622cfed5a76231fff8bdbf86d"
    sha256 cellar: :any_skip_relocation, monterey:       "730dd20c7291e466bd568056e72f4723feab53eccf80ba35a2f0101d7f7ba1ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "7f1a4a1e00c14050d3246b66cf554797b184e5c6be2eb53ebb2edfe6845412e5"
    sha256 cellar: :any_skip_relocation, catalina:       "bb6bfe4999b4675d3e3d16a52552fe571430fa5956fdff245837f922d7e39842"
    sha256 cellar: :any_skip_relocation, mojave:         "335fda7dd0c4cbd0a2c929daf19693729b3e1592f1880f5a1cb2ebd5ae587c3c"
    sha256 cellar: :any_skip_relocation, high_sierra:    "622cd7695294bcac63049e45e934ea1936dfc0f9373046dd028f63a3fe6fa2a4"
    sha256 cellar: :any_skip_relocation, sierra:         "15dfb147f388a8a486714d17d519a1ad1195f79bad5843d37726e8efaab1ae79"
    sha256 cellar: :any_skip_relocation, el_capitan:     "44d0ab83d1bc3ee71294d328dc70dd14206b8d8ddf05a195f2cdf354d746d5dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2844f0cc79cb84f523def0ec75eb6821a5613e7ed7f19390e7574e04b943303a"
  end

  def install
    system "make", "all"
    bin.install %w[peg leg]
    man1.install Utils::Gzip.compress("src/peg.1")
  end

  test do
    (testpath/"username.peg").write <<~EOS
      start <- "username"
    EOS

    system "#{bin}/peg", "-o", "username.c", "username.peg"

    assert_match 'yymatchString(yy, "username")', File.read("username.c")
  end
end
