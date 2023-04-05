#!/system/bin/sh
MODDIR=${0%/*}

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done
while [ ! -d "/sdcard/Android" ]; do
    sleep 1
done

chmod 0755 -R $MODDIR/*
$MODDIR/init.postboot.sh >/data/init.log 2>&1 &
