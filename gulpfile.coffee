gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'

gulp.task 'test', ->
  gutil.log 'Version 0.0.0 - actual code coming soon.'

gulp.task 'build', ->
  gulp.src './lib-src/**/*.coffee'
    .pipe(coffee(bare: true)).on('error', gutil.log)
    .pipe(gulp.dest('./lib'))
