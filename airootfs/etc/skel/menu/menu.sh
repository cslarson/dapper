#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $DIR/actions.sh

DATA_DIR=/media/dapper-data
GETH_DIR=$DATA_DIR/geth
GETH_IPC=$GETH_DIR/geth.ipc
PARITY_DIR=$DATA_DIR/parity
PARITY_IPC=$PARITY_DIR/jsonrpc.ipc
#PARITY_DAPPS_PORT=8080

DAPPER_DATA_ACTION=Attach
if mountpoint -q $DATA_DIR ; then
    DAPPER_DATA_ACTION=Eject
fi

# sleep .5

CHOICE=$(whiptail --title "Dapper Menu" --menu "Choose an action" 15 60 5 \
"1" "$DAPPER_DATA_ACTION dapper-data" \
"2" "Use Parity WebUI/Parity" \
"3" "Use MyEtherWallet offline" \
"4" "Reboot" \
"5" "Shutdown"  3>&1 1>&2 2>&3)

# CHOICE=$(whiptail --title "Dapper Menu" --menu "Choose an action" 15 60 7 \
# "1" "$DAPPER_DATA_ACTION dapper-data" \
# "2" "Use Mist/Geth" \
# "3" "Use Mist/Parity" \
# "4" "Use Parity WebUI/Parity" \
# "5" "Use MyEtherWallet offline" \
# "6" "Reboot" \
# "7" "Shutdown"  3>&1 1>&2 2>&3)
# exitstatus=$?

case $CHOICE in
  1)
    mountpoint -q /media/dapper-data && umount /media/dapper-data || mount /media/dapper-data
  ;;
  # 2)
  #   if nodeUp $GETH_IPC ; then
  #     termite --hold -e "mist --rpc $GETH_IPC" > /dev/null 2>&1 & restart
  #   else
  #     termite --hold -e "geth --datadir $GETH_DIR" > /dev/null 2>&1 &
  #     waitNode $GETH_IPC
  #     termite --hold -e "mist --rpc $GETH_IPC" > /dev/null 2>&1 & restart
  #   fi
  # ;;
  # 3)
  #   if nodeUp $PARITY_IPC ; then
  #     # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 & restart
  #     termite --hold -e "mist --rpc $PARITY_IPC" > /dev/null 2>&1 & restart
  #   else
  #     termite --hold -e "parity --geth --datadir $PARITY_DIR" > /dev/null 2>&1 &
  #     waitNode $PARITY_IPC
  #     # firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & restart
  #     termite --hold -e "mist --rpc $PARITY_IPC" > /dev/null 2>&1 & restart
  #   fi
  # ;;
  2)
    if nodeUp $PARITY_IPC ; then
      #firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      firejail chromium http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      #firejail epiphany http://127.0.0.1:8180 > /dev/null 2>&1 & restart
    else
      # termite --hold -e "parity --datadir $PARITY_DIR" > /dev/null 2>&1 &
      termite --hold -e "parity --datadir $PARITY_DIR" &
      waitNode $PARITY_IPC
      #firejail chromium --proxy-server='localhost:8118' http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      firejail chromium http://127.0.0.1:8180 > /dev/null 2>&1 & restart
      #firejail epiphany http://127.0.0.1:8180 > /dev/null 2>&1 & restart
    fi
  ;;
  3)
    firejail chromium file:///opt/MyEtherWallet/index.html > /dev/null 2>&1 & restart
  ;;
  4)
    systemctl reboot
  ;;
  5)
    systemctl poweroff
  ;;
esac
