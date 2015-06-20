{ChiptuneJsPlayer, ChiptuneJsConfig} = require 'chiplib'

songs = require '../tunes/data.json'

main = ->
  player = new ChiptuneJsPlayer new ChiptuneJsConfig 1
  index = (Math.random() * songs.length) | 0
  console.log 'playing', songs[index]
  player.load '/s/tunes/' + index, (buffer) ->
    player.play buffer

main()
