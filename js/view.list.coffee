define 'view.list', ->
  EntryView = require 'view.entry'

  class ListView extends Backbone.View
    el: $('.list-view')

    ###*
    Constructor
    ###

    initialize: ->
      @entries = Data.entries

      @listenTo @entries,
        'reset': @reset
        'add':   @add

    ###*
    Removes all entries.
    ###

    reset: (entries) =>
      @$el.html("")
      entries.each (entry) => @add(entry)

    ###*
    Adds an entry.
    ###

    add: (entry) =>
      view = new EntryView(entry: entry)
      @$el.append view.render().el

