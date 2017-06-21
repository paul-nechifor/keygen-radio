#!/bin/bash

set -e

root=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

main() {
  cd "$root"

  [[ -d node_modules ]] || npm i
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
  rm -fr dist
  build_deps
  gulp --production
  (
    cd dist;
    cat deps.js ../crlf client.js > js.js
    rm deps.js client.js
  )
}

debug() {
  # vagrant up local
  build_deps debug
  gulp
  rm -f crlf
  # copy_build
}

build_deps() {
  mkdir -p dist
  rsync -a --del static/ dist/
  if [[ "$1" ]]; then
    cat \
      node_modules/chiplib/libopenmpt.js crlf \
      node_modules/jquery/dist/jquery.js crlf \
      > dist/deps.js
  else
    cat \
      node_modules/chiplib/libopenmpt.js crlf \
      node_modules/jquery/dist/jquery.min.js crlf \
      > dist/deps.js
  fi
  rsync -a --del tunes/files/ dist/tunes/

  export PATH="$PATH:node_modules/.bin"
  [[ -d dist/fonts ]] || mkdir -p dist/fonts
  cp fonts/chintzy.ttf dist/fonts
  ttf2woff fonts/chintzy.ttf dist/fonts/chintzy.woff
  ttf2eot fonts/chintzy.ttf dist/fonts/chintzy.eot
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
