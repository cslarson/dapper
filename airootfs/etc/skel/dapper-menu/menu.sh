#!/bin/bash
. ./actions.sh

TERMINAL=termite
DATA_DIR=/media/dapper-data
GETH_DIR=$DATA_DIR/geth
GETH_IPC=$GETH_DIR/geth.ipc
PARITY_DIR=$DATA_DIR/parity
PARITY_IPC=$PARITY_DIR/jsonrpc.ipc

DAPPER_DATA_ACTION=Attach
if mountpoint -q $DATA_DIR ; then
    DAPPER_DATA_ACTION=Eject
fi

CHOICE=$(whiptail --title "Test Menu Dialog" --menu "Choose your option" 15 60 6 \
"1" "Open internet settings" \
"2" "$DAPPER_DATA_ACTION dapper-data" \
"3" "Use Mist" \
"4" "Use Parity" \
"5" "Shutdown" \
"6" "Reboot"  3>&1 1>&2 2>&3)

exitstatus=$?

case $CHOICE in
  1)
    $TERMINAL --hold -e "connman-ncurses" > /dev/null 2>&1 & ./$0
  ;;
  2)
    mountpoint -q /media/dapper-data && umount /media/dapper-data || mount /media/dapper-data
  ;;
  3)
    if nodeUp $GETH_IPC ; then
      $TERMINAL --hold -e "mist --rpc $GETH_IPC" & ./$0
    else
      $TERMINAL --hold -e "geth --datadir $GETH_DIR" > /dev/null 2>&1 &
      waitNode $GETH_IPC
      $TERMINAL --hold -e "mist --rpc $GETH_IPC" > /dev/null 2>&1 & ./$0
    fi
  ;;
  4)
    if nodeUp $PARITY_IPC ; then
      firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 & ./$0
    else
      $TERMINAL --hold -e "parity --datadir $PARITY_DIR" > /dev/null 2>&1 &
      waitNode $PARITY_IPC
      firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & ./$0
    fi
  ;;
  5)
    systemctl poweroff
  ;;
  6)
    systemctl reboot
  ;;
esac
