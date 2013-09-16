all: assets

include make/Makefile.base
include make/Makefile.cachebust
include make/Makefile.stylus
include make/Makefile.coffeescript
include make/Makefile.uglifyjs
include make/Makefile.images
include make/Makefile.favicon

assets: \
	$(image_files) \
	favicon.ico \
	assets/vendor.js \
	assets/style.css \
	assets/app.js

assets/style.css: \
	assets/_reset.css \
	assets/_base.css \
	css/nprogress.css
	cat $^ > $@

assets/vendor.js: \
	vendor/jquery-2.0.2.js \
	vendor/respond-1.1.0.js \
	vendor/underscore-1.4.4.js \
	vendor/backbone-1.0.0.js \
	vendor/moment-2.0.0.js \
	vendor/nprogress.js \
	vendor/jquery.fillsize.js \
	vendor/masonry.js \
	vendor/almond.js
	cat $^ | $(uglify) -m > $@

assets/app.js: $(coffee_js_files)
	cat $^ > $@

