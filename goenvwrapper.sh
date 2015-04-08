#!/bin/bash
# Copyright (c) Paul R. Tagliamonte, MIT/Expat, 2015


function mkgoenv {
    env=$1
    if [ "x${env}" = "x" ]; then
        echo "Please give me a name!"
    else
        if [ ! -d ~/.goenvs/${env}/ ]; then
            mkdir -p ~/.goenvs/${env}/
            hackon ${env}
        else
            echo "That goenv already exists; use hackon"
        fi
    fi
}


function hackon {
    env=$1
    if [ "x${env}" = "x" ]; then
        echo "Please give me a name!"
    else
        if [ -d ~/.goenvs/${env}/ ]; then
            export GOPATH=~/.goenvs/${env}/
            export OLD_PS1="${PS1}"
            export PS1="(${env})${PS1}"
        else
            echo "That goenv doesn't exist!"
        fi
    fi
}


function unhackon {
    unset GOPATH
    export PS1=${OLD_PS1}
    unset OLD_PS1
}
