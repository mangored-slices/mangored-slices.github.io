define 'router.app', ->
  $html = $('html')
  L = require('locale.en')
  EntryDialogView = require 'view.entry_dialog'

  class AppRouter extends Backbone.Router
    routes:
      '': 'home'
      'on/:service': 'service'
      'e/:slug': 'entry'

    home: ->
      App.loader.ping()

      @title null
      @klass "home"

      App.menuView.activate null
      App.listView.filterBy null

    service: (service) ->
      App.loader.ping()

      @title L.posts[service]
      @klass "service-#{service} service"

      App.menuView.activate service
      App.listView.filterBy service

    entry: (slug) ->
      App.loader.ping()

      # Fetch
      entry = Data.entries.findBySlug(slug)
      unless entry
        alert "Unknown entry"
        return

      # Activate
      service = entry.source().name
      @title entry.toString()
      App.menuView.activate service

      # Open the dialog
      new EntryDialogView(model: entry).render()

    ###*
    * Changes the body class name.
    ###
    klass: (str) ->
      if m = $html.data('mode')
        $html.removeClass m

      $html
        .addClass(str)
        .data('mode', str)

    ###*
    * Changes title.
    ###
    title: (str) ->
      if str
        str = "#{str} &mdash; MangoRed Slices"
      else
        str = "MangoRed Slices"

      $('title').html str

