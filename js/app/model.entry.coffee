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
      entry.source()
      entry.source().name
      entry.source().service
    ###

    source: ->
      @get('source')

    ###*
      entry.typeClass()   #=> "text" / "image"
    ###

    typeClass: ->
      if @get('image')?.length > 0
        'image'
      else
        'text'

    isImage:  -> @typeClass() is 'image'
    isText:   -> @typeClass() is 'text'

    isVertical:   -> @ratio() < 0.8
    isHorizontal: -> @ratio() > 1.2

    ratio: -> @get('image_ratio') or 1

    slug: -> @cid

    toString: ->
      @get('text') || ''

    ###*
       date('ago')       #=> "3 days ago"
       date('long')      #=> September 16th, 2013
    ###

    date: (fmt) ->
      if fmt is 'ago'
        moment(@get('date')).fromNow()
      else #long
        moment(@get('date')).format('MMMM Do, YYYY')

# -----
define 'collection.entries', ->
  class Entries extends Backbone.Collection
    model: require('model.entry')

    findBySlug: (slug) ->
      @detect (entry) -> entry.cid is slug
