# Keygen Radio

Listen endlessly to keygen chiptunes in JS.

## Usage

To make it work, you need some chiptunes. If you don't have a dir called
`./tunes` (the default) the `./do` script below will get some from
[keygenmusic.org](http://keygenmusic.org).

Build the dev version:

    ./do

This will start a server on [localhost:8000](http://localhost:8000).

Build the production version:

    ./do production

That deletes any previous build and creates the production one. You can start a
server with:

    gulp serve
