define 'view.list', ->
  r = (role) -> "[role~='#{role}']"
  immediate = (fn) -> setTimeout fn, 0

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

    ###* Projected speed of relayouting ###
    speed: 1000

    ###* Spacing between items (0..1) ###
    scatter: 0.25

    ###* Constructor
    ###

    initialize: ->
      @entries = Data.entries

      @listenTo @entries,
        'reset': @reset
        'add':   @add

    render: ->
      # Activate masonry on tablet/desktop, and off on mobile.
      @media = Harvey.attach 'screen and (min-width: 480px)',
        on: =>
          @$el
            .addClass('masonry-layout')
            .masonry
              columnWidth: 20
              itemSelector: "article:not(.hide)"
        off: =>
          @$(r 'image').unfillsize()
          @$el
            .removeClass('masonry-layout')
            .masonry('destroy')

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

      $(document).queue (next) =>
        @$el.append(view.render().el)
        @$el.masonry('appended', view.$el) if @media.active

        if Math.random() < @scatter
          $ph = $("<article class='entry-item h1 w1 placeholder'></article>")
          @$el.append($ph)
          @$el.masonry('appended', $ph) if @media.active

        @relayout()
        next()

    ###*
    # Filters by a given service
    #
    #     filterBy('instagram')
    #     filterBy(null)
    ###

    filterBy: (service) =>
      $(document).queue (next) =>
        if service
          @$(r 'entry').addClass('hide')
          @$('.placeholder').addClass('hide')
          @$(r 'entry').filter(".service-#{service}").removeClass('hide')
        else
          @$(r 'entry').removeClass('hide')
          @$('.placeholder').removeClass('hide')

        @relayout()
        setTimeout next, @speed

    ###*
    # Update layouts
    ####

    relayout: ->
      immediate =>
        if @media.active
          @$el.masonry('reloadItems')
          @$el.masonry()
        @$el.trigger('fillsize')
