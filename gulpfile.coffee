argv = require('yargs').argv
gulp = require 'gulp'
gulpIf = require 'gulp-if'
nib = require 'nib'
rename = require 'gulp-rename'

gulp.task 'default', ['js', 'css'], ->
  gulp.src './templates/index.jade'
  .pipe require('gulp-jade') locals: production: argv.production
  .pipe gulp.dest './dist'

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
  .pipe gulp.dest './dist'

gulp.task 'css', ->
  gulp.src './css/index.styl'
  .pipe require('gulp-stylus')
    compress: argv.production
    use: nib()
  .pipe rename basename: 'css'
  .pipe gulp.dest './dist'
