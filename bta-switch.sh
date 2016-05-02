#!/bin/bash
#
# Since docker run can only have one "entry point" this script enables calling
# either log2timeline or other utility scripts e.g.
# docker run <container_id> btaminer
# docker run <container_id> btaimport
# docker run <container_id> btadiff
# docker run <container_id> btamanage

export LD_LIBRARY_PATH=/usr/local/lib/

function bta_help {
  /usr/local/bin/btaminer -h 
}  

case "$1" in
  btaminer|btaminer.py)
    /usr/local/bin/btaminer "${@:2}" ;;
  btaimport|btaimport.py)
    /usr/local/bin/btaimport "${@:2}" ;;
  btadiff|btadiff.py)
    /usr/local/bin/btadiff "${@:2}" ;;
  btamanage|btamanage.py)
    /usr/local/bin/btamanage "${@:2}" ;;
  "")
    /usr/local/bin/btaminer "${@:2}" ;;  
  *)
    bta_help;;
esac