argv = require('yargs').argv
gulp = require 'gulp'
gulpIf = require 'gulp-if'

gulp.task 'default', ['js'], ->
  gulp.src './templates/index.jade'
  .pipe require('gulp-jade') locals: production: argv.production
  .pipe gulp.dest './build'

gulp.task 'js', ->
  sourcemaps = require 'gulp-sourcemaps'
  require('browserify')
    entries: './client'
    debug: not argv.production
    noParse: ['./libopenmpt.js']
    transform: ['coffeeify']
    extensions: ['.coffee']
  .bundle()
  .pipe require('vinyl-source-stream') './client.js'
  .pipe require('vinyl-buffer')()
  .pipe sourcemaps.init loadMaps: true
  .pipe require('gulp-uglify')()
  .on 'error', require('gulp-util').log
  .pipe gulpIf not argv.production, sourcemaps.write './'
  .pipe gulp.dest './build/s'
