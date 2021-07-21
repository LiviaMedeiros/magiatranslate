#!/bin/bash
BASEDIR="$(realpath "$(dirname "${0}")")"
keytool -genkey \
	-storetype pkcs12 \
	-keystore "${BASEDIR}/ekaterina.keystore" \
	-alias ekaterina \
	-keyalg RSA \
	-sigalg SHA512withRSA \
	-keysize 4096 \
	-validity 5050
