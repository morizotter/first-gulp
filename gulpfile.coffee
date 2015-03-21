gulp   = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'compile-coffee', () ->
  gulp.src 'path/to/coffee/source/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('/path/to/js')
