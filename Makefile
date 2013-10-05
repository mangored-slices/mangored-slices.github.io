all: assets

include make/Makefile.base
include make/Makefile.watch
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
	assets/_menu.css \
	assets/_entries.css \
	assets/_title-card.css \
	assets/_entry-dialog.css \
	css/nprogress.css
	cat $^ > $@

assets/vendor.js: \
	vendor/jquery-2.0.2.js \
	vendor/respond.js \
	vendor/underscore.js \
	vendor/underscore-string.js \
	vendor/backbone.js \
	vendor/backbone-analytics.js \
	vendor/moment.js \
	vendor/nprogress.js \
	vendor/jquery.fillsize.js \
	vendor/masonry.js \
	vendor/jquery-cookie.js \
	vendor/ndialog.js \
	vendor/harvey.js \
	vendor/almond.js
	cat $^ | $(uglify) -m > $@

assets/app.js: $(coffee_js_files)
	cat $^ > $@

