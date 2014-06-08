gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
mocha = require 'gulp-mocha'

gulp.task 'build', ->
  gulp.src './lib-src/**/*.coffee'
    .pipe(coffee(bare: true)).on('error', gutil.log)
    .pipe(gulp.dest('./lib'))

gulp.task 'test', ['build'], ->
  gulp.src 'test/**/*.coffee'
    .pipe(mocha())
