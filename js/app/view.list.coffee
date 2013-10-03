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
    el: $(r 'list_view')

    ###* Entries collection ###
    entries: null

    ###* Masonry instance ###
    masonry: null

    ###* Constructor
    ###

    initialize: ->
      @entries = Data.entries

      @listenTo @entries,
        'reset': @reset
        'add':   @add

    render: ->
      @$el.masonry
        columnWidth: 20
        itemSelector: "article"

      this

    ###* Removes all entries.
    ###

    reset: (entries) =>
      @$el.html("")
      entries.each (entry) => @add(entry)

    ###* Adds an entry.
    ###

    add: (entry) =>
      i = @$el.children().length
      firstOfType = @$el.find(".service-#{entry.source().name}").length is 0
      view = new EntryView(entry: entry, index: i, class: ('active' if firstOfType))

      @$el
        .append(view.render().el)
        .masonry('appended', view.$el)

      if Math.random() < 0.3
        $ph = $("<article class='entry-item h1 w1 placeholder'></article>")
        @$el
          .append($ph)
          .masonry('appended', $ph)

      @relayout()

    filterBy: (service) =>
      if service
        @$(r 'entry').hide()
        @$(r 'entry').filter(".service-#{service}").show()
      else
        @$(r 'entry').show()

      @relayout()

    ###* Update layouts ###
    relayout: ->
      @$el.masonry()
      @$el.trigger('fillsize')
