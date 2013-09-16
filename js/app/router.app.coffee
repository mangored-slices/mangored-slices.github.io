define 'router.app', ->
  class AppRouter extends Backbone.Router
    routes:
      '': 'home'
      'on/:service': 'service'
      'entry/:cid': 'entry'

    home: ->
      App.menuView.activate null
      App.listView.filterBy null

    service: (service) ->
      App.menuView.activate service
      App.listView.filterBy service

    entry: (cid) ->
      # ...
