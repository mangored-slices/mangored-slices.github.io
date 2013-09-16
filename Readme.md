MangoRed Slices
===============

Frontend source files.

Development setup
-----------------

You need to have these installed:

 * Node.js -- to run Stylus and CoffeeScript
 * GNU Make -- manages build system (comes with Mac OS X and all Linux distros)
 * Stylus -- for CSS pre-processing
 * CoffeeScript -- for JS pre-processing
 * Imagemagick and Optipng -- for optimizing images

Frontend technologies
---------------------

 * jQuery
 * Backbone.js -- MVC and stuff
 * Masonry.js -- for layouts
 * Almond.js -- for organizing modules via AMD
 * A bunch of other things

File structure
--------------

    css/       - Source stylesheet files (stylus)
    js/        - Source script files (coffee)
    images/    - Source image files
    assets/    - Compiled stylesheet+script+images files

Updating files
--------------

Use `make` to update all the `asset/` files:

    make

