class Verible < Formula
  desc "SystemVerilog developer tools"
  homepage "https://github.com/chipsalliance/verible"
  version "0.0-4298-g085eef05"
  sha256 "260ff58d63188e175d2f63be2823a65dcea21383ee4a83f370fd3e1b05f0e977"
  url "https://github.com/chipsalliance/verible/releases/download/v#{version}/verible-v#{version}-macOS.tar.gz",
  license "Apache-2.0"

  depends_on :macos

  def install
    bin.install %w[
      bin/verible-verilog-diff
      bin/verible-verilog-format
      bin/verible-verilog-kythe-extractor
      bin/verible-verilog-lint
      bin/verible-verilog-ls
      bin/verible-verilog-obfuscate
      bin/verible-verilog-preprocessor
      bin/verible-verilog-project
      bin/verible-verilog-syntax
    ]
  end

  test do
    (testpath/"test.sv").write <<~EOS
      module    m   ;endmodule
    EOS
    (testpath/"test_formatted.sv").write <<~EOS
      module m;
      endmodule
    EOS
    output = shell_output("#{bin}/verible-verilog-format test.sv")
    assert_equal File.read(testpath/"test_formatted.sv"), output
  end
end
