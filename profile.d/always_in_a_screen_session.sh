#if [[ -n "${SSH_TTY}" ]] && [[ -z "${STY}" ]]; then
#   screen -xRR && exit
#fi