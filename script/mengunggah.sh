#!/usr/bin/env bash

perangkat=$(grep lunch $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
nama_rom=$(grep init $CIRRUS_WORKING_DIR/build.sh -m 1 | cut -d / -f 4)

cd
cd $WORKDIR/rom/$nama_rom/out/target/product/$perangkat/system_ext/priv-app/$APPS
curl -F document=@$APPS.apk "https://api.telegram.org/bot${TG_TOKEN}/sendDocument" \
    -F chat_id="${TG_CHAT_ID}" \
    -F "disable_web_page_preview=true" \
    -F "parse_mode=html" \
    -F caption="${APPS}.apk"

rclone copy $APPS.apk mobx:Apps/Derp-13/$perangkat -P
