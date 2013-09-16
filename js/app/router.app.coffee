define 'router.app', ->
  class AppRouter extends Backbone.Router
    routes:
      '': 'home'
      'on/:service': 'service'
      'e/:slug': 'entry'

    home: ->
      App.loader.ping()
      App.menuView.activate null
      App.listView.filterBy null

    service: (service) ->
      App.loader.ping()
      App.menuView.activate service
      App.listView.filterBy service

    entry: (slug) ->
      App.loader.ping()
      entry = Data.entries.findBySlug(slug)

      if entry
        console.log "Load", entry.get('text')
      else
        alert "Unknown entry"

