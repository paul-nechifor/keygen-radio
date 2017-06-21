{NodeWrapper} = require 'chiplib'

songs = require '../tunes/data.json'
context = new AudioContext

main = ->
  loopIt = ->
    playRandomSong (err) ->
      console.log err if err
      setTimeout loopIt

  loopIt()

playRandomSong = (cb) ->
  index = (Math.random() * songs.length) | 0
  song = songs[index]
  $('.song-name') .text "Playing: #{song[0]} - #{song[1]}"

  loadTune 'tunes/' + index, (err, tune) ->
    return cb "Error on loading song #{index}." if err
    new NodeWrapper context, tune
    .start (err) ->
      return cb "Error on finishing song #{index}." if err
      cb()

loadTune = (path, cb) ->
  xhr = new XMLHttpRequest
  xhr.open 'GET', path, true
  xhr.responseType = 'arraybuffer'

  returned = false
  cb2 = (err, data) ->
    return if returned
    cb err, data

  xhr.onload = (e) ->
    return cb2 'loading error' unless xhr.status is 200 and e.total
    cb2 null, xhr.response

  xhr.onerror = xhr.onabort = ->
    cb2 'loading error'

  xhr.send()

$ main
