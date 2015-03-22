gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
compass     = require 'gulp-compass'
minifyCss   = require 'gulp-minify-css'
concat      = require 'gulp-concat'
haml        = require 'gulp-ruby-haml'
watch       = require 'gulp-watch'
webserver   = require 'gulp-webserver'
runSequence = require 'run-sequence'

dir =
  src: '_source'
  dist: 'public'

gulp.task 'coffee', ->
  gulp.src "#{dir.src}/coffee/**/*.coffee"
  .pipe coffee()
  .pipe gulp.dest "#{dir.src}/js"

gulp.task 'uglify', ->
  compileFileName = 'application.js'
  gulp.src "#{dir.src}/js/**/*.js"
  .pipe concat(compileFileName)
  .pipe uglify()
  .pipe gulp.dest "#{dir.dist}/asset/js"

gulp.task 'compass', ->
  gulp.src "#{dir.src}/scss/**/*.scss"
  .pipe(compass({
    config_file: 'config.rb'
    css: "#{dir.src}/css/"
    sass: "#{dir.src}/scss/"
  }))

gulp.task 'minify', ->
  compileFileName = 'application.css'
  gulp.src "#{dir.src}/css/**/*.css"
  .pipe concat(compileFileName)
  .pipe minifyCss()
  .pipe gulp.dest "#{dir.dist}/asset/css"

gulp.task 'haml', ->
  gulp.src "#{dir.src}/app/**/*.haml"
  .pipe haml({ doubleQuote: true })
  .pipe gulp.dest "#{dir.dist}"

gulp.task 'copy', ->
  gulp.src([
    "#{dir.src}/image/**/*"
  ])
  .pipe gulp.dest "#{dir.dist}/asset/image"

gulp.task 'webserver', ->
  gulp.src "#{dir.dist}"
  .pipe(webserver({
    livereload: true
    port: 9000
    fallback: "#{dir.dist}/index.html"
    open: true
    })
  )

gulp.task 'build', ->
 runSequence(
  ['coffee','compass','haml'],
  ['uglify', 'minify'],
  'copy'
  )

gulp.task 'watch', ->
  gulp.watch ["#{dir.src}/scss/**/*.scss", "#{dir.src}/coffee/**/*.coffee", "#{dir.src}/app/**/*.haml"], ['build']

gulp.task 'serve', ->
  runSequence(
    ['build'],
    ['webserver']
    )
