#!/usr/bin/env bash
set -e

HOST=broad
VM=$HOST-vm

SYSTEM=systems/x86_64-linux/$HOST

# --------------------------------- Commands --------------------------------- #

build() {
  if [ -f "$SYSTEM/PREBUILD.sh" ]; then
    $SYSTEM/PREBUILD.sh
  fi
  nix build --impure .#vm-noguiConfigurations.$VM
}

run() {
  sudo result/bin/run-$VM
}

setup() {
  ansible-playbook -K $XDG_REMOTE_DIR/OneDrive/Documents/Keys/deploy-keys.yaml
}

update() {
  shutdown
  build
  run
}

reboot() {
  ssh -t $HOST 'sudo reboot'
}

shutdown() {
  ssh -t $HOST 'sudo poweroff'
}

cleanup() {
  rm -f result
  rm -f $HOST.qcow2
}

# ---------------------------------- Script ---------------------------------- #

usage() {
  echo "Usage: $0 {build|run|setup|update|reboot|shutdown|cleanup}"
  exit 1
}

if [ $# -eq 0 ]; then
  usage
fi

case "$1" in
build)
  build
  ;;
run)
  run
  ;;
setup)
  setup
  ;;
update)
  update
  ;;
reboot)
  reboot
  ;;
shutdown)
  shutdown
  ;;
cleanup)
  cleanup
  ;;
*)
  usage
  ;;
esac
