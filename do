#!/bin/bash

root=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

main() {
  cd "$root"

  [[ -d node_modules ]] || npm i
  [[ -d bower_components ]] || bower install

  echo -e '\n;\n' > crlf

  if [[ "$1" ]]; then
    "$@"
  else
    build "$@"
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

build() {
  build_deps debug
  gulp
  gulp serve
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
}

main "$@"
