cask "claudeusagetracker" do
  version "1.5.0"
  sha256 "12690b6db47865bec7a78cb3021874b6b2c8aa53a867d24c2c5284e2672035ef"

  url "https://github.com/masorange/ClaudeUsageTracker/releases/download/v#{version}/ClaudeUsageTracker-v#{version}.dmg"
  name "Claude Usage Tracker"
  desc "Track your Claude Code API usage from your macOS menu bar"
  homepage "https://github.com/masorange/ClaudeUsageTracker"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ClaudeUsageTracker.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/ClaudeUsageTracker.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.claudeusage.tracker.plist",
  ]
end
