#!/system/bin/bash
MODDIR=${0%/*}
chmod 0755 -R $MODDIR/*
wait_until_login() {
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done
    local test_file="/sdcard/Android/.LOGIN_PERMISSION_TEST"
    true >"$test_file"
    while [ ! -f "$test_file" ]; do
        true >"$test_file"
        sleep 1
    done
    rm "$test_file"
}
wait_until_login
$MODDIR/init.postboot.sh >/cache/init.log 2>&1 &

if [ -f /storage/emulated/0/Android/VK_Controller/normal.conf ]; then
    [ ! -f "$MODDIR"/VK_Controller.conf ] && touch "$MODDIR"/VK_Controller.conf
    cat /storage/emulated/0/Android/VK_Controller/normal.conf >"$MODDIR"/VK_Controller.conf
else
    exit
fi
if [ -f /storage/emulated/0/Android/VK_Controller/custom.conf ]; then
    cat /storage/emulated/0/Android/VK_Controller/custom.conf >>"$MODDIR"/VK_Controller.conf
fi
nohup $MODDIR/PowerHalHelper "$MODDIR"/VK_Controller.conf >/cache/running.log 2>&1 &
