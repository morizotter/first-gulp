gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
compass     = require 'gulp-compass'
minifyCss   = require 'gulp-minify-css'
concat      = require 'gulp-concat'
watch       = require 'gulp-watch'
webserver   = require 'gulp-webserver'
runSequence = require 'run-sequence'

gulp.task 'coffee', ->
  gulp.src 'source/coffee/**/*.coffee'
  .pipe coffee()
  .pipe gulp.dest('source/js')

gulp.task 'uglify', ->
  compileFileName = 'application.js'
  gulp.src 'source/js/**/*.js'
  .pipe concat(compileFileName)
  .pipe uglify()
  .pipe gulp.dest('dist/asset/js')

gulp.task 'compass', ->
  gulp.src 'source/scss/**/*.scss'
  .pipe(compass({
    config_file: 'config.rb'
    css: 'source/css/'
    sass: 'source/scss/'
  }))

gulp.task 'minify', ->
  compileFileName = 'application.css'
  gulp.src 'source/css/**/*.css'
  .pipe concat(compileFileName)
  .pipe minifyCss()
  .pipe gulp.dest('dist/asset/css')

gulp.task 'copy', ->
  gulp.src([
    'source/app/**/*.html'
  ])
  .pipe(gulp.dest('dist'))
  gulp.src([
    'source/image/**/*'
  ])
  .pipe(gulp.dest('dist/asset/image'))

gulp.task 'webserver', ->
  gulp.src('dist')
  .pipe(webserver({
    livereload: true
    port: 9000
    fallback: 'dist/index.html'
    open: true
    })
  )

gulp.task 'build', ->
 runSequence(
  ['coffee','compass'],
  ['uglify', 'minify'],
  'copy'
  )

gulp.task 'watch', ->
  gulp.watch ['source/scss/**/*.scss', 'source/coffee/**/*.coffee', 'source/app/**/*.html'], ['build']

gulp.task 'serve', ->
  runSequence(
    ['build'],
    ['webserver']
    )
