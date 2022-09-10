# Audioswitch

Audioswitch is a [Hammerspoon](https://www.hammerspoon.org) that allows you to change input/output devices on the fly with simple global hotkeys.

## Installation

First, download and install Hammerspoon. You can do so either [from their Github](https://github.com/Hammerspoon/hammerspoon/releases/latest), or if you have it installed, through homebrew simply by running:

```bash
$ brew install Hammerspoon
```

in the terminal. Once you have it installed, run it, and follow the prompts to grant accessibility permissions (I also choose to hide the app from the dock here so it stays out of your command-tab switcher)

You also need to allow external apps to control VoiceOver through AppleScript. To do so, open VoiceOver utility with VO + f8, navigate to the "General" section and check the "Allow VoiceOver to be controlled with AppleScript" checkbox.

Once Hammerspoon is installed and configured, navigate into the folder where you cloned this repository with Finder or another file manager, and open "Audioswitch.spoon" which should cause Hammerspoon to install it into the right place. Finally, from the Hammerspoon menu extra select the open configuration option which should open your default text editor with your init.lua file. To make Audioswitch work and do its thing, simply add the following 2 lines:

```lua
hs.loadSpoon("Audioswitch")
spoon.Audioswitch:start()
```

Save the file, return to the Hammerspoon menu extra but this time click the reload configuration option for your new changes to take effect. Mac OS will warn you that Hammerspoon is trying to control Voice Over. Grant it permission and the spoon should start working.

## Features

| Command | Description |
| --- | --- |
| Control+Shift+[ | Cycle back an output device |
| Control+Shift+] | Cycle forward an output device |
| Control+Command+Shift+[ | Cycle back an input device |
| Control+Command+Shift+] | Cycle forward an input device |

## Contributing

If there's a feature you'd like to see added, feel free to open a pull request/issue. I'd prefer issues get opened before forging ahead with huge pull requests, unless the feature is already on the todo list.

## Credits

Instillation instructions adapted from [Indent Beeper](https://github.com/pitermach/IndentBeeper), and [Speech History](http://github.com/mikolysz/speech-history).
