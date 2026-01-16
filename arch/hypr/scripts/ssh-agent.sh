#!/bin/bash

# Start the SSH agent if it's not already running
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    eval "$(ssh-agent -s)" > /dev/null
#fi

# Add your SSH keys (replace with your key paths)
#ssh-add ~/.ssh/gh > /dev/null 2>&1
#ssh-add ~/.ssh/hexly > /dev/null 2>&1
# Add more keys as needed

#eval "$(keychain --eval hexly)"
#eval "$(keychain --eval gh)"