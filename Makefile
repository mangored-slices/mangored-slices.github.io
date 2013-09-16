# config
# ------

js_files := $(patsubst %.coffee, %.js, $(patsubst js/%, assets/_%, $(shell ls js/*)))
cachebust_files := index.html

# manifests
# ---------

all: \
	assets/vendor.js \
	assets/style.css \
	assets/app.js

assets/style.css: \
	assets/_reset.css \
	assets/_base.css \
	css/nprogress.css
	cat $^ > $@

assets/vendor.js: \
	vendor/respond-1.1.0.js \
	vendor/jquery-2.0.2.js \
	vendor/underscore-1.4.4.js \
	vendor/backbone-1.0.0.js \
	vendor/moment-2.0.0.js \
	vendor/nprogress.js \
	vendor/almond.js
	cat $^ | $(compress) > $@

assets/app.js: $(js_files)
	cat $^ > $@

# filters
# -------

assets/_%.css: css/%.styl node_modules
	$(stylus) -I css -u nib < $< > $@

assets/_%.js: js/%.coffee node_modules
	$(coffee) -cp $< > $@

# utilities
# ---------

stylus ?= ./node_modules/.bin/stylus
stylus ?= ./node_modules/.bin/stylus
uglify ?= ./node_modules/.bin/uglifyjs
coffee ?= ./node_modules/.bin/coffee
compress ?= $(uglify) -m

node_modules: package.json
	npm install
	touch $@

# cachebusting
# ------------

cachebust:
	perl -p -i -e "s/\?v=[0-9]+/?v=`echo $$RANDOM`/" $(cachebust_files)

