#!/bin/bash

set -e

root=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

main() {
  cd "$root"

  [[ -d node_modules ]] || npm i
  [[ -d bower_components ]] || bower install
  [[ -d tunes ]] || ./scripts/download-music-pack

  echo -e '\n;\n' > crlf

  if [[ "$1" ]]; then
    "$@"
  else
    debug
  fi

  rm -f crlf
}

production() {
  rm -fr build
  build_deps
  gulp --production
  (
    cd build/s;
    cat deps.js ../../crlf client.js > js.js
    rm deps.js client.js
  )
}

debug() {
  vagrant up local
  build_deps debug
  gulp
  rm -f crlf
  copy_build
}

build_deps() {
  mkdir -p build/s
  if [[ "$1" ]]; then
    cat \
      node_modules/chiplib/libopenmpt.js crlf \
      bower_components/jquery/dist/jquery.js crlf \
      > build/s/deps.js
  else
    cat \
      node_modules/chiplib/libopenmpt.js crlf \
      bower_components/jquery/dist/jquery.min.js crlf \
      > build/s/deps.js
  fi
  rsync -a --del tunes/files/ build/s/tunes/
}

copy_build() {
  vagrant ssh local -- 'sudo rsync -tr --del /vagrant/build/ /var/www/keygenradio/'
}

copy_build_to_production() {
  local ip=$(
    vagrant ssh keygen-radio-remote -- ifconfig eth0 |
    grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'
  )
  echo "$ip"
  local opts=(
    ssh
    -o Compression=yes
    -o StrictHostKeyChecking=no
    -o UserKnownHostsFile=/dev/null
    -o IdentitiesOnly=yes
    -i ~/.ssh/vagrant_do_rsa
  )
  rsync -e "${opts[*]}" -trv --del build/ "root@$ip:/var/www/keygenradio/"
}

main "$@"
