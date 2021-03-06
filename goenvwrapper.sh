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

function rmgoenv {
    env=$1

    if [ "x${GOENVNAME}" = "x${env}" ]; then
        echo "Can't remove the active env"
        return
    fi

    if [ "x${env}" = "x" ]; then
        echo "Please give me a name!"
    else
        if [ -d ~/.goenvs/${env}/ ]; then
            rm -rf ~/.goenvs/${env}/
        else
            echo "No such go env exists"
        fi
    fi
}


function hackon {
    env=$1
    if [ "x${GOENVNAME}" != "x" ]; then
        echo "Already hacking on something!"
        return
    fi

    if [ "x${env}" = "x" ]; then
        echo "Please give me a name!"
    else
        if [ -d ~/.goenvs/${env}/ ]; then
            export GOENVNAME=${env}
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
    unset GOENVNAME
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

    ENVPATH=${GOPATH}/src/${IMPORT_PATH}

    if [ -e ${ENVPATH} ]; then
        echo "Already present as ${ENVPATH}. Hunh. Remove it?"
        return
    fi

    mkdir -p $(dirname ${ENVPATH})
    ln -s ${DEVDIR} ${ENVPATH}
}
