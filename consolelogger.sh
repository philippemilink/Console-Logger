#!/bin/bash


function print_commands()
{
    echo -e "           init  start the logging";
    echo -e " end [filename]  end the logging in save commands in filename";
}

function init()
{
    echo "Start logging"
}

function end()
{
    first_line=$(grep -ne "^$0 init$"  ~/.bash_history | tail -n1)

    if [[ $first_line == '' ]]
    then
	echo "You must first run '$0 init'"
	exit
    fi

    writing=0;
    count=0;

    cat ~/.bash_history | while  read line
    do
	  count=$((count+1));
			      
	  if [ $writing -eq 1 ]
	  then
	      echo $line >> $1
	  fi

	  if [[ $(echo $count:$line) = $first_line ]]
	  then
	      writing=1;
	  fi
    done
}


if [ $# -eq 0 ]
then
    echo "Console Logger - a tool to log commands put in a shell"
    print_commands
    exit
fi



if [[ $1 == 'init' && $# -eq 1 ]]
then
    init
elif [[ $1 == 'end' && $# -eq 2 ]]
then
    echo "Saving"
    end $2
else
    echo "Unknown command"
    print_commands
fi
