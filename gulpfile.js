var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var browserSync = require('browser-sync').create();

/*
 * Variables
 */
// Sass Source
// var scssFiles = './src/scss/style.scss';

var PATH = {
	css: './sites/all/themes/direitofavoravel/css/',
	scss: './sites/all/themes/direitofavoravel/scss/'
};

// CSS destination
var cssDest = './sites/all/themes/direitofavoravel/css';

// Options for development
var sassDevOptions = {
  outputStyle: 'expanded'
}

// Options for production
var sassProdOptions = {
  outputStyle: 'compressed'
}

/*
 * Tasks
 */
// Task 'sassdev' - Run with command 'gulp sassdev'
gulp.task('sassdev', function() {
  return gulp.src(PATH.scss + 'style.scss')
    .pipe(sass(sassDevOptions).on('error', sass.logError))
    .pipe(gulp.dest(PATH.css));
});

// Task 'sassprod' - Run with command 'gulp sassprod'
gulp.task('sassprod', function() {
  return gulp.src(PATH.scss + 'style.scss')
    .pipe(sass(sassProdOptions).on('error', sass.logError))
    .pipe(rename('style.min.css'))
    .pipe(gulp.dest(PATH.css));
});

// Task 'watch' - Run with command 'gulp watch'
gulp.task('watch', function() {
  gulp.watch(PATH.scss + '*.scss', ['sassdev', 'sassprod']);
});

// Default task - Run with command 'gulp'
gulp.task('default', ['sassdev', 'sassprod', 'watch']);

// Static Server + watching scss/html files
gulp.task('server', ['sassdev', 'sassprod'], function() {

    browserSync.init({
        proxy: "direitofavoravel.dev"
    });

    gulp.watch(PATH.scss + '*.scss', ['sassdev', 'sassprod']);
    gulp.watch("**/*.html").on('change', browserSync.reload);
});