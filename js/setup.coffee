$ ->
  Data = window.Data = {}
  Data.entries   = new (require 'collection.entries')
  Data.accounts  = new (require 'collection.accounts')

  App  = window.App = {}
  App.config  = (require 'app.config')
  App.router  = new (require 'router.app')
  App.fetcher = new (require 'app.fetcher')

  # Fuego!
  App.fetcher.fetch()
  .done ->
    console.log("[History] start")
    Backbone.history.start()
