# config
# ------

js_files := $(patsubst %.coffee, %.js, $(patsubst js/%, assets/_%, $(shell find js -type f)))
image_files := $(patsubst %.jpg.png, %.jpg, $(patsubst images/%, assets/%, $(shell find images -type f)))
cachebust_files := index.html

# manifests
# ---------

all: \
	$(image_files) \
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
	vendor/q-0.9.2.js \
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
	mkdir -p `dirname $@`
	$(stylus) -I css -u nib < $< > $@

assets/_%.js: js/%.coffee node_modules
	mkdir -p `dirname $@`
	$(coffee) -bcp $< > $@

# Optimize pngs
assets/%.png: images/%.png
	$(optipng) -quiet -clobber $< -out $@

# utilities
# ---------

stylus ?= ./node_modules/.bin/stylus
stylus ?= ./node_modules/.bin/stylus
uglify ?= ./node_modules/.bin/uglifyjs
coffee ?= ./node_modules/.bin/coffee
optipng ?= optipng

compress ?= $(uglify) -m

node_modules: package.json
	npm install
	touch $@

# cachebusting
# ------------

cachebust:
	perl -p -i -e "s/\?v=[0-9]+/?v=`echo $$RANDOM`/" $(cachebust_files)

