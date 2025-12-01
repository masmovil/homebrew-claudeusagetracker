cask "claudeusagetracker" do
  version "1.6.0"
  sha256 "a522306bc40cd66ed62ab8ff98e351086ba0315752658958010b8f7bcfcca86f"

  url "https://github.com/masorange/ClaudeUsageTracker/releases/download/v#{version}/ClaudeUsageTracker-v#{version}.dmg"
  name "Claude Usage Tracker"
  desc "Track your Claude Code API usage from your macOS menu bar"
  homepage "https://github.com/masorange/ClaudeUsageTracker"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "ClaudeUsageTracker.app"

  # Close app before upgrade (prevents conflicts)
  uninstall_preflight do
    system_command "/usr/bin/killall",
                   args: ["ClaudeUsageTracker"],
                   sudo: false,
                   print_stderr: false
  end

  postflight do
    # Remove quarantine attributes (ignore errors if already removed)
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClaudeUsageTracker.app"],
                   sudo: false,
                   print_stderr: false

    # Small delay to ensure app directory is ready
    sleep 0.5

    # Open the new version
    system_command "/usr/bin/open",
                   args: ["-a", "Claude Usage Tracker"],
                   sudo: false,
                   print_stderr: false
  end

  caveats do
    <<~EOS
      Claude Usage Tracker has been #{version == "1.6.0" ? "installed" : "updated"}!

      The app should open automatically. If it doesn't, launch it manually:
        open -a "Claude Usage Tracker"

      The app runs in your menu bar. Look for the 💰 icon.
    EOS
  end

  zap trash: [
    "~/Library/Preferences/com.claudeusage.tracker.plist",
  ]
end
