class Gwm < Formula
  desc "Open and tile Ghostty windows in a grid"
  homepage "https://github.com/tgriek/ghostty-window-manager"
  url "https://github.com/tgriek/ghostty-window-manager/releases/download/v0.1.0/gwm-0.1.0-macos-universal.tar.gz"
  sha256 "728da32470767280f9aa8dc660c027206a9d365d2f44a824095aec090975e536"
  license "MIT"

  depends_on macos: :sonoma

  # Prebuilt universal (arm64 + x86_64) binary from `make dist`, so no Xcode is needed.
  def install
    bin.install "gwm"
  end

  def caveats
    <<~EOS
      gwm drives Ghostty 1.3 or later. Grant Accessibility (and, when asked,
      Automation) permission to the app you run gwm from, normally Ghostty:
        System Settings > Privacy & Security > Accessibility

      Personal defaults (e.g. the command typed into each window) go in
        ~/.config/gwm/config
      See https://github.com/tgriek/ghostty-window-manager#configuration
    EOS
  end

  test do
    assert_match "gwm <RxC>", shell_output("#{bin}/gwm --help")
    assert_match "Invalid grid", shell_output("#{bin}/gwm 0x3 2>&1", 64)
  end
end
