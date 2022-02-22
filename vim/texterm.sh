#!/bin/bash
#
# Open new iTerm window from the command line
#
# Usage:
#     iterm                   Opens the current directory in a new iTerm window
#     iterm [PATH]            Open PATH in a new iTerm window
#     iterm [CMD]             Open a new iTerm window and execute CMD
#     iterm [PATH] [CMD] ...  You can prob'ly guess
#
# Example:
#     iterm ~/Code/HelloWorld ./setup.sh
#
# References:
#     iTerm AppleScript Examples:
#     https://gitlab.com/gnachman/iterm2/wikis/Applescript
# 
# Credit:
#     Inspired by tab.bash by @bobthecow
#     link: https://gist.github.com/bobthecow/757788
#

# OSX only
[ "$(uname -s)" != "Darwin" ] && return

function iterm () {
    local arg="$1"

    osascript &>/dev/null <<EOF
        tell application "iTerm"
            activate
            tell current session of current window
                delay 0.5
                write text "cd $(PWD)"
                write text "/usr/local/bin/vim $arg"
            end tell
        end tell
EOF
}

iterm "$1"
