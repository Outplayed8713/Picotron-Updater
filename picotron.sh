#!/bin/bash
dir="$(dirname -- "$(readlink -f -- "$0")")"
$dir/picotron_update.sh
if [[ -e $dir/picotron/picotron ]]; then
  echo "Starting Picotron!"
  $dir/picotron/picotron
fi
