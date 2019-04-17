#!/bin/sh

os=$1

case ${os} in

  linux   ) echo ${HOME};;
  windows ) echo "${APPDATA}\\.emacs.d";;
  macos   ) echo ${HOME};;

esac
