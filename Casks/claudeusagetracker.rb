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

  postflight do
    # Remove quarantine attributes
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/ClaudeUsageTracker.app"],
                   sudo: false

    # Check if app is running and close it gracefully
    system_command "/usr/bin/pgrep",
                   args: ["-x", "ClaudeUsageTracker"],
                   sudo: false,
                   print_stderr: false

    # If running (exit code 0), kill it
    if $?.exitstatus == 0
      system_command "/usr/bin/killall",
                     args: ["ClaudeUsageTracker"],
                     sudo: false,
                     print_stderr: false

      # Wait for app to close
      sleep 1
    end

    # Open the new version
    system_command "/usr/bin/open",
                   args: ["-a", "Claude Usage Tracker"],
                   sudo: false
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
