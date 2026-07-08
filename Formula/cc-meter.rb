class CcMeter < Formula
  desc "macOS menu bar app showing your Claude Code usage limits"
  homepage "https://github.com/raheelkazi/cc-meter"
  url "https://github.com/raheelkazi/cc-meter/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "cb032416c5acabc75e218ef7d5a378e5ad297877847564fec82bd2383f23a746"
  license "MIT"

  depends_on xcode: :build
  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/cc-meter"
  end

  service do
    run [opt_bin/"cc-meter"]
    # KeepAlive so `brew services start` launches it immediately (RunAtLoad
    # alone does not fire when bootstrapped into an active login session).
    # successful_exit: false means a clean Quit (exit 0) is NOT relaunched, so
    # the popover Quit button still works; a crash (non-zero) is restarted.
    keep_alive successful_exit: false
    run_at_load true
    log_path var/"log/cc-meter.log"
    error_log_path var/"log/cc-meter.log"
  end

  test do
    assert_predicate bin/"cc-meter", :executable?
  end
end
