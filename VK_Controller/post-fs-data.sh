#!/system/bin/sh
MODDIR=${0%/*}
magiskpolicy --apply $MODDIR/sepolicy.rule