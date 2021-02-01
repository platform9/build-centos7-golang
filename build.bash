#!/bin/bash
set -eo pipefail
[ ! -z "${BASH_DEBUG}" ] && set -x

pushd $(dirname $0)
    make
popd
