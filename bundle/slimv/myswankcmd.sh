osascript -e "tell application \"iTerm\"
    make new terminal
    tell the current terminal
        activate current session
        launch session \"Hotkey Window\"
        tell the last session
            write text \"sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp\"
        end tell
    end tell
end tell" &
