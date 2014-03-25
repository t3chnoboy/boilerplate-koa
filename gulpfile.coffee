gulp       = require 'gulp'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
mocha      = require 'gulp-mocha'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
nodemon    = require 'gulp-nodemon'
imagemin   = require 'gulp-imagemin'
coffeeES6  = require 'gulp-coffee-es6'
livereload = require 'gulp-livereload'

paths =
  views       : 'src/public/**/*.jade'
  styles      : 'src/public/stylesheets/**/*.styl'
  images      : 'src/public/images/**/*'
  scripts     : 'src/public/scripts/**/*.coffee'
  server      : ['src/*.coffee', 'src/routes/*.coffee']
  dest        : 'public'

gulp.task 'server-scripts', ->
  gulp.src paths.server
    .pipe coffeeES6 bare: yes
    .pipe gulp.dest './'

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee()
    .pipe uglify()
    .pipe concat 'all.min.js'
    .pipe gulp.dest paths.dest + '/scripts'
    .pipe livereload()

gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest paths.dest + '/stylesheets'
    .pipe livereload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe imagemin()
    .pipe gulp.dest paths.dest + '/images'
    .pipe livereload()

gulp.task 'views', ->
  gulp.src paths.views
    .pipe jade()
    .pipe gulp.dest paths.dest
    .pipe livereload()

gulp.task 'rendered-views', ->
  gulp.src 'views/**/*.jade'
    .pipe livereload()

gulp.task 'server', ->
  nodemon
    script: 'app.js'
    nodeArgs: ['--harmony']
    ignore: [
      './src/**'
      './test/**'
      './public/**'
      './node_modules/**'
    ]

gulp.task 'watch', ->
  gulp.watch paths.views       , ['views']
  gulp.watch paths.styles      , ['styles']
  gulp.watch paths.scripts     , ['scripts']
  gulp.watch paths.server      , ['server-scripts']
  gulp.watch 'views/**/*.jade' , ['rendered-views']


gulp.task 'default', ['views', 'styles', 'scripts', 'images', 'server-scripts', 'watch', 'server']
