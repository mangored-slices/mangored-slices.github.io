define 'router.app', ->
  class AppRouter extends Backbone.Router
    routes:
      '': 'home'
      'on/:service': 'service'
      'entry/:cid': 'entry'

    home: ->
      console.log("[AppRouter] home")

    service: (service) ->
      console.log("[AppRouter] Service")

    entry: (cid) ->
      # ...
