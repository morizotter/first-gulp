gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
sass        = require 'gulp-sass'
minifyCss   = require 'gulp-minify-css'
concat      = require 'gulp-concat'
watch       = require 'gulp-watch'
webserver   = require 'gulp-webserver'
runSequence = require 'run-sequence'

gulp.task 'compile-coffee', ->
  gulp.src 'source/coffee/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('source/js')

gulp.task 'compile-js', ->
  compileFileName = 'application.js'
  gulp.src 'source/js/**/*.js'
    .pipe concat(compileFileName)
    .pipe uglify()
    .pipe gulp.dest('dist/asset/js')

gulp.task 'compile-sass', ->
  gulp.src 'source/scss/**/*.scss'
    .pipe sass()
    .pipe gulp.dest('source/css')

gulp.task 'compile-css', ->
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

gulp.task('webserver', ->
  gulp.src('dist')
    .pipe(webserver({
      livereload: true
      port: 9000
      fallback: 'dist/index.html'
      open: true
      }))
  )

gulp.task 'compile', -> runSequence(
  ['compile-coffee','compile-sass'],
  ['compile-js', 'compile-css'],
  'copy'
  )

gulp.task 'watch', ->
  gulp.watch ['source/scss/**/*.scss', 'source/coffee/**/*.coffee', 'source/app/**/*.html'], ['compile']
