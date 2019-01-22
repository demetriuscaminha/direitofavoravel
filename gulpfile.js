var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var browserSync = require('browser-sync').create();

var PATH = {
	css: './sites/all/themes/direitofavoravel/css/',
	scss: './sites/all/themes/direitofavoravel/scss/'
};

gulp.task('styles', function(){
    gulp.src(PATH.scss + 'style.scss')
    .pipe(sass())
    .pipe(gulp.dest(PATH.css))
    .pipe(browserSync.stream());
});

// Static Server + watching scss/html files
gulp.task('server', function() {

    browserSync.init({
        proxy: "direitofavoravel.dev"
    });

    gulp.watch(PATH.scss + '*.scss', ['styles']);
    gulp.watch("./**/*.html").on('change', browserSync.reload);
});

gulp.task('default', ['styles', 'server']);