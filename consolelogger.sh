#!/bin/bash


function print_commands()
{
    echo -e "           init  start the logging";
    echo -e " end [filename]  end the logging in save commands in filename";
    echo -e " cd [directory]  move to the directory"
}

function alias_cd()
{
    alias cd='consolelogger cd'
}

function init()
{
    pwd > ~/.consolelogger_directories
    alias_cd
    echo "Start logging"
}

function changedirectory()
{
    
    \cd $1
    alias_cd 
    pwd >> ~/.consolelogger_directories
}


function end()
{
    first_line=$(egrep -n "consolelogger(.sh)? init$"  ~/.bash_history | tail -n1)

    if [[ $first_line == '' ]]
    then
	   echo "You must first run '$0 init'"
	exit
    fi

    writing=0;
    count=0;

    i=1
    while read line
    do 
        directories[$i]=$line
        i=$(($i+1))
    done < ~/.consolelogger_directories

    current_directory=1

    cat ~/.bash_history | while read line
    do
        count=$((count+1));
			      
        if [ $writing -eq 1 ]
        then
            if [[ ${line:0:1} == "c" && ${line:1:1} == "d" ]]
            then
                if [[ ${#line} -gt 2 ]]
                then
                    if [[ ${line:2:1} != " " ]]
                    then
                        # Not cd command:
                        echo ${directories[$current_directory]}:$line >> $1
                    else
                        current_directory=$((current_directory+1))
                    fi
                else
                    current_directory=$((current_directory+1))
                fi
            else
                echo ${directories[$current_directory]}:$line >> $1
            fi
        fi

        if [[ $(echo $count:$line) = $first_line ]]
        then
            writing=1;
        fi
    done

    alias cd='\cd'
    rm ~/.consolelogger_directories
}


if [ $# -eq 0 ]
then
    echo "Console Logger - a tool to log commands put in a shell"
    print_commands
    return 0
fi



if [[ $1 == 'init' && $# -eq 1 ]]
then
    init
elif [[ $1 == 'end' && $# -eq 2 ]]
then
    echo "Saving"
    end $2
elif [[ $1 == 'cd' ]]
then
    changedirectory $2
else
    echo "Unknown command"
    print_commands

fi
