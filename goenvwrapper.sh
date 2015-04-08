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
            export OLD_PATH="${PATH}"
            export PS1="(${env})${PS1}"
            export PATH="${PATH}:~/.goenvs/${env}/bin/"
        else
            echo "That goenv doesn't exist!"
        fi
    fi
}


function unhackon {
    unset GOPATH
    export PS1=${OLD_PS1}
    export PATH=${OLD_PATH}
    unset OLD_PS1
    unset OLD_PATH
}


function add2goenv {
    DEVDIR=$1
    IMPORT_PATH=$2

    if [ "x${DEVDIR}" = "x" ]; then
        echo "usage: add2virtualenv . github.com/paultag/rules"
        return
    fi

    DEVDIR=$(readlink -f ${DEVDIR})

    if [ "x${IMPORT_PATH}" = "x" ]; then
        echo "usage: add2virtualenv . github.com/paultag/rules"
        return
    fi

    if [ -e ${GOPATH}/src/${IMPORT_PATH} ]; then
        echo "Already present as ${GOPATH}/src/${IMPORT_PATH}. Hunh. Remove it?"
        return
    fi

    ln -s ${DEVDIR} ${GOPATH}/src/${IMPORT_PATH}
}
