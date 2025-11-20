cask "claudeusagetracker" do
  version "1.0.0"
  sha256 "826258519438e5dda0770f35f11d0698d3fcc9cd8ff57ba8a49227bb5eca5e33"

  url "https://github.com/masmovil/ClaudeUsageTracker/releases/download/v#{version}/ClaudeUsageTracker-v#{version}.dmg"
  name "Claude Usage Tracker"
  desc "Track your Claude Code API usage from your macOS menu bar"
  homepage "https://github.com/masmovil/ClaudeUsageTracker"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ClaudeUsageTracker.app"

  zap trash: [
    "~/Library/Preferences/com.claudeusage.tracker.plist",
  ]
end
