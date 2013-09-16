define 'model.entry', ->
  ###*
  An entry.

  Fields:

   * `date`  -- (string) date
   * `image` -- (string) URL
   * `image_large` -- (string) URL
   * `image_ratio` -- (number) width-over-height ratio
   * `text` -- (string) Title
   * `fulltext` -- (string) Full text
   * `url` -- (href) permalink URL
   * `source` -- (object) source name
  ###

  class Entry extends Backbone.Model

    ###*
      entry.dateAgo()   #=> "a few seconds ago"
    ###

    dateAgo: ->
      moment(@get('date')).fromNow()
    ###*
      entry.typeClass()   #=> "text" / "image"
    ###
    typeClass: ->
      if @get('image')?.length > 0
        'image'
      else
        'text'

# -----
define 'collection.entries', ->
  class Entries extends Backbone.Collection
    model: require('model.entry')
