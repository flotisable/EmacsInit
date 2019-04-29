#!/bin/sh

os=$1

case ${os} in

  Linux       ) echo ${HOME};;
  Windows_NT  ) echo "${APPDATA}\\.emacs.d";;
  Darwin      ) echo ${HOME};;

esac
