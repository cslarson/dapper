DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function nodeUp {

  # if ! nc -Uz $1 ; then
  #   echo node NOT up
  #   return 1
  # else
  #   echo node IS up
  #   return 0
  # fi

  [ -S $1 ] && return 0 || return 1
}

function restart {
  # sleep .5
  $DIR/menu.sh
}

function waitNode {

  # until nc -Uz $1
  # do
  #   sleep 1
  # done
  # echo here

  until nodeUp $1 ; do
    sleep 1
    echo "please wait..."
  done

}
