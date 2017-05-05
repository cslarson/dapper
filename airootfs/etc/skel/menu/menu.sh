#!/bin/bash
. /home/dapper/menu/actions.sh

MENU=/home/dapper/menu/menu.sh
TERMINAL=termite #gnome-terminal
DATA_DIR=/media/dapper-data
GETH_DIR=$DATA_DIR/geth
GETH_IPC=$GETH_DIR/geth.ipc
PARITY_DIR=$DATA_DIR/parity
PARITY_IPC=$PARITY_DIR/jsonrpc.ipc

DAPPER_DATA_ACTION=Attach
if mountpoint -q $DATA_DIR ; then
    DAPPER_DATA_ACTION=Eject
fi

# sleep .5

CHOICE=$(whiptail --title "Dapper Menu" --menu "Choose an action" 15 60 6 \
"1" "$DAPPER_DATA_ACTION dapper-data" \
"2" "Use Mist/Geth" \
"3" "Use Mist/Parity" \
"4" "Use Parity WebUI/Parity" \
"5" "Shutdown" \
"6" "Reboot"  3>&1 1>&2 2>&3)
# exitstatus=$?

case $CHOICE in
  1)
    mountpoint -q /media/dapper-data && umount /media/dapper-data || mount /media/dapper-data
  ;;
  2)
    if nodeUp $GETH_IPC ; then
      $TERMINAL --hold -e "mist --rpc $GETH_IPC" > /dev/null 2>&1 & restart
    else
      $TERMINAL --hold -e "geth --datadir $GETH_DIR" > /dev/null 2>&1 &
      waitNode $GETH_IPC
      $TERMINAL --hold -e "mist --rpc $GETH_IPC" > /dev/null 2>&1 & restart
    fi
  ;;
  3)
    if nodeUp $PARITY_IPC ; then
      # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 & restart
      $TERMINAL --hold -e "mist --rpc $PARITY_IPC" > /dev/null 2>&1 & restart
    else
      $TERMINAL --hold -e "parity --geth --datadir $PARITY_DIR" > /dev/null 2>&1 &
      waitNode $PARITY_IPC
      # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      $TERMINAL --hold -e "mist --rpc $PARITY_IPC" > /dev/null 2>&1 & restart
    fi
  ;;
  4)
    if nodeUp $PARITY_IPC ; then
      # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 & restart
      firejail epiphany http://127.0.0.1:8180 > /dev/null 2>&1 & restart
    else
      $TERMINAL --hold -e "parity --datadir $PARITY_DIR" > /dev/null 2>&1 &
      waitNode $PARITY_IPC
      # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      firejail epiphany http://127.0.0.1:8180 > /dev/null 2>&1 & restart
    fi
  ;;
  5)
    systemctl poweroff
  ;;
  6)
    systemctl reboot
  ;;
esac
