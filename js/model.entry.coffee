define 'model.entry', ->
  class Entry extends Backbone.Model

# -----
define 'model.entries', ->
  class Entries extends Backbone.Collection
    model: require('model.entry')
