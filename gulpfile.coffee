gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
uglify      = require 'gulp-uglify'
sass        = require 'gulp-sass'
minifyCss   = require 'gulp-minify-css'
concat      = require 'gulp-concat'

gulp.task 'compile-coffee', () ->
  gulp.src 'source/coffee/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('source/js')

gulp.task 'compile-js', () ->
  compileFileName = 'application.js'
  gulp.src 'source/js/**/*.js'
    .pipe concat(compileFileName)
    .pipe uglify()
    .pipe gulp.dest('dist/js')

gulp.task 'compile-sass', () ->
    gulp.src 'source/scss/**/*.scss'
      .pipe sass()
      .pipe gulp.dest('source/css')

gulp.task 'compile-css', () ->
  compileFileName = 'application.css'
  gulp.src 'source/css/**/*.css'
    .pipe concat(compileFileName)
    .pipe minifyCss()
    .pipe gulp.dest('dist/css')

gulp.task 'compile', ['compile-coffee', 'compile-sass', 'compile-js', 'compile-css']
