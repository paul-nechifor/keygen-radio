# Keygen Radio

Listen endlessly to keygen chiptunes in JS. This is the source code for [Keygen
Radio][kgradio].

## Development

To make it work, you need some chiptunes. If you don't have a dir called
`./tunes` (the default) the `./do` script below will get some from
[keygenmusic.org][kgmusic]

Build everything with:

    npm install
    npm run build

Everything that's required will be built in `./dist`. Start a static server that
will serve it with:

    npm start

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
