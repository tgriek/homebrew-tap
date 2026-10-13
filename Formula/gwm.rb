class Gwm < Formula
  desc "Open and tile Ghostty windows in a grid"
  homepage "https://github.com/tgriek/ghostty-window-manager"
  url "https://github.com/tgriek/ghostty-window-manager/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4bff1f33d662d024fe7b2d67b25d971847f185206f8d1162dc5fee08059696a5"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/gwm"
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
