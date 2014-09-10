# autotime.zsh

This is a simple script which tracks the time taken by every command executed
in zsh and prints the time elapsed if it's greater than N seconds. (N is
hardcoded to 7 right now).

## Install

Clone this repository and source the file autotime.zsh from your zshrc.

    git clone https://github.com/utkarshkukreti/autotime.zsh
    echo "source $(pwd)/autotime.zsh/autotime.zsh" >> ~/.zshrc
