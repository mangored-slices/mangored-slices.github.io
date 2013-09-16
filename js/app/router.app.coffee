define 'router.app', ->
  class AppRouter extends Backbone.Router
    routes:
      '': 'home'

    home: ->
      console.log("[AppRouter] home")
