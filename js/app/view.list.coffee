define 'view.list', ->
  r = (role) -> "[role~='#{role}']"

  EntryView = require 'view.entry'

  ###*
    List view.

    Common usage:

        App.listView.filterBy('instagram')
        App.listView.filterBy(null)
  ###

  class ListView extends Backbone.View
    el: $('[role~="list_view"]')

    ###* Constructor
    ###

    initialize: ->
      @entries = Data.entries

      @listenTo @entries,
        'reset': @reset
        'add':   @add

    ###* Removes all entries.
    ###

    reset: (entries) =>
      @$el.html("")
      entries.each (entry) => @add(entry)

    ###* Adds an entry.
    ###

    add: (entry) =>
      view = new EntryView(entry: entry)
      @$el.append view.render().el

    filterBy: (service) =>
      if service
        @$(r 'entry').hide()
        @$(r 'entry').filter(".service-#{service}").show()
      else
        @$(r 'entry').show()
