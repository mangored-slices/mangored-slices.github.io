define 'app', ->
  App = {}
  App.router  = new require('router.app')
  App.fetcher = new require('app.fetcher')

  App

$ ->
  window.App = require('app')

  Backbone.history.start()
