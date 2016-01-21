#!/usr/bin/env bash
# Inspired by: https://gist.github.com/neilellis/2d25f0ade3d6cae6f7c9
# Expects three arguments, the name of the project, environment and stack file
#

set -eu

if ! which tutum >/dev/null
then
    echo "Please install Tutum CLI using 'sudo -H pip install tutum'"
    exit 1
fi

if (( $# != 3))
then
    echo "Usage: $0 <stack-file> <project> <env>"
    exit 1
fi

stackfile=$1
project=$2
environment=$3

if tutum stack list | grep ${project}-${environment}
then
    echo "We have a stack running, update"
    tutum stack update ${project}-${environment} --sync -f $stackfile
    echo "Redeploy"
    tutum stack redeploy ${project}-${environment} --sync
    echo "Done"
else
    echo "We have to create one"
    tutum stack up -n ${project}-${environment} --sync -f $stackfile
fi
