#!/usr/bin/env bash

# Enable auto updates
sudo softwareupdate --schedule on

# Disable AirDrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES

# Set time and date automatically
sudo systemsetup setusingnetworktime on

# Require a password to wake the computer from sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1

# Ensure screen locks immediately when requested
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disable remote Apple Events
sudo systemsetup -setremoteappleevents off

# Disable remote login
sudo systemsetup -f -setremotelogin off
