define 'router.app', ->

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

      @title service
      @klass "service-#{service}"

      App.menuView.activate service
      App.listView.filterBy service

    entry: (slug) ->
      App.loader.ping()

      entry = Data.entries.findBySlug(slug)

      @title entry.toString()
      @klass "service-#{entry.source().name}"

      if entry
        console.log "Load", entry.get('text')
      else
        alert "Unknown entry"

    ###
    # Changes the body class name.
    ###
    klass: (str) ->
      $('body').attr class: str

    ###
    # Changes title.
    ###
    title: (str) ->
      if str
        str = "#{str} &mdash; MangoRed Slices"
      else
        str = "MangoRed Slices"

      $('title').html str

