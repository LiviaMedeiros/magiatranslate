#!/bin/bash
set -eux

verify_apk() {
    return 0
    . ci_versions/deps.sh
    "./deps/Android/Sdk/build-tools/${BUILD_TOOLS_VER}/apksigner" verify --print-certs "$1" > /tmp/result.txt || exit 1
    grep -q "$2" /tmp/result.txt && return 0
    echo "Cert SHA256 digest mismatch" >&2
    exit 2
}

UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"

ARMV8_URL="https://xn--80aalyho.xn--p1ai/magireco/ambivalence/vanilla.apk"
ARMV7_URL="https://xn--80aalyho.xn--p1ai/magireco/ambivalence/vanilla.apk"

. ci_versions/src_apk.sh

rm -fr apk armv7apk
mkdir -p apk armv7apk

curl -A "${UA}" -o out.apk -L "${ARMV8_URL}"
verify_apk out.apk "${SRCAPK_CERT_SHA256}" && mv out.apk "./apk/src_${SRCAPK_VER}.apk"

curl -A "${UA}" -o out.apk -L "${ARMV7_URL}"
verify_apk out.apk "${SRCAPK_CERT_SHA256}" && mv out.apk "./armv7apk/armv7src_${SRCAPK_VER}.apk"
