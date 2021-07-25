#!/bin/bash
BASEDIR="$(realpath "$(dirname "${0}")")"
rm -rf "${BASEDIR}/pydep"
pip install -r "${BASEDIR}/requirements.txt" -U -t "${BASEDIR}/pydep"
