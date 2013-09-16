define 'model.entry', ->
  class Entry extends Backbone.Model

# -----
define 'collection.entries', ->
  class Entries extends Backbone.Collection
    model: require('model.entry')
