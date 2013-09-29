define 'router.app', ->
  $html = $('html')
  L = require('locale.en')

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
      @klass "service-#{service}"

      App.menuView.activate service
      App.listView.filterBy service

    entry: (slug) ->
      App.loader.ping()

      entry = Data.entries.findBySlug(slug)
      service = entry.source().name

      @title entry.toString()
      @klass "service-#{service}"

      if entry
        console.log "Load", entry.get('text')
      else
        alert "Unknown entry"

      App.menuView.activate service
      # TODO: show entry dialog

    ###
    # Changes the body class name.
    ###
    klass: (str) ->
      if m = $html.data('mode')
        $html.removeClass m

      $html
        .addClass(str)
        .data('mode', str)

    ###
    # Changes title.
    ###
    title: (str) ->
      if str
        str = "#{str} &mdash; MangoRed Slices"
      else
        str = "MangoRed Slices"

      $('title').html str

