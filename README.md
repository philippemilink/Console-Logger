# Console-Logger
A light bash script to save into a file commands written in a shell


## Installation

Clone this repository

Edit your `~/.bash_profile` file and add these lines:
```shell
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias consolelogger='. [folder where you clone]Console-Logger/consolelogger.sh'
```

Load this file with `source ~/.bash_profile` or restart your shell.


## Usage

Start logging:
```shell
consolelogger init
```

You can add comment in your logging file:
```shell
consolelogger comment Your comment
```

And when you want to end logging and save it into a file:
```shell
consolelogger end save.md
```