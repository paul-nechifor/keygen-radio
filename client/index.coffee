{ChiptuneJsPlayer, ChiptuneJsConfig} = require 'chiplib'

songs = [
  '/s/tunes/mysteristerium.mod'
  '/s/tunes/rfchip001.xm'
  '/s/tunes/cydonian sky.xm'
  '/s/tunes/chipsounds.mod'
]

main = ->
  player = new ChiptuneJsPlayer new ChiptuneJsConfig 1
  path = songs[(Math.random() * 4) | 0]
  player.load path, (buffer) ->
    player.play buffer

main()
