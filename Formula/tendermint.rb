class Tendermint < Formula
  desc "BFT state machine replication for applications in any programming languages"
  homepage "https://tendermint.com/"
  url "https://github.com/tendermint/tendermint/archive/v0.34.13.tar.gz"
  sha256 "d52f6eb0489a837f072975d2a41e24f4cbd974ec12a7f6c6025d20cd97110860"
  license "Apache-2.0"
  head "https://github.com/tendermint/tendermint.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d069288a129924e9c6c8c80af2ccaf78b71b724c794e1830ebbbba6669d09f0d"
    sha256 cellar: :any_skip_relocation, big_sur:       "9473894f1f5e2d7e08817844045172af8a62b17db2ddd819fb019aa9014aa587"
    sha256 cellar: :any_skip_relocation, catalina:      "9473894f1f5e2d7e08817844045172af8a62b17db2ddd819fb019aa9014aa587"
    sha256 cellar: :any_skip_relocation, mojave:        "9473894f1f5e2d7e08817844045172af8a62b17db2ddd819fb019aa9014aa587"
  end

  depends_on "go" => :build

  def install
    system "make", "build", "VERSION=#{version}"
    bin.install "build/tendermint"
  end

  test do
    mkdir(testpath/"staging")
    shell_output("#{bin}/tendermint init --home #{testpath}/staging")
    assert_predicate testpath/"staging/config/genesis.json", :exist?
    assert_predicate testpath/"staging/config/config.toml", :exist?
    assert_predicate testpath/"staging/data", :exist?
  end
end
