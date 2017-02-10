# Console-Logger
A light bash script to save into a file commands written in a shell


## Installation

Clone this repository

Edit your `~/.bash_profile` file and add these lines:
```
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias consolelogger='[folder when you clone]Console-Logger/consolelogger.sh'
```

Load this file with `source ~/.bash_profile` or restart your shell.


## Usage

Start logging:
```
consolelogger init
```

And when you want to end logging and save it into a file:
```
consolelogger end save.md
```