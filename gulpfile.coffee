gulp   = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'compile-coffee', () ->
  gulp.src 'source/coffee/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('dist/js')
