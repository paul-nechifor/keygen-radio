# Keygen Radio

Listen endlessly to keygen chiptunes in JS. This is the source code for [Keygen
Radio][kgradio].

## Development

Requirements: Vagrant, Gulp, Ubuntu.

To make it work, you need some chiptunes. If you don't have a dir called
`./tunes` (the default) the `./do` script below will get some from
[keygenmusic.org][kgmusic]

Build the dev version:

    ./do

That will start Vagrant if it's not started and build all the necessary things.
The Nginx server inside Vagrant will be available at
[172.18.123.121](http://172.18.123.121).

Build the production version:

    ./do production

That deletes any previous build and creates the production one. You can now copy
that deployment to Vagrant with:

    ./do copy_build

## Acknowledgements

This uses [chiplib][chiplib], my fork of Simon Gündling's
[chiptune2][chiptune2]. It uses Emscripten to transpile [libopenmpt][libopenmpt]
into JavaScript.

## TODO

- Add a modal for more info on the homepage.

## License

GPL v2

[kgradio]: http://keygenradio.com
[kgmusic]: http://keygenmusic.org
[chiplib]: https://github.com/paul-nechifor/chiplib
[chiptune2]: https://github.com/deskjet/chiptune2.js
[libopenmpt]: http://lib.openmpt.org/libopenmpt
