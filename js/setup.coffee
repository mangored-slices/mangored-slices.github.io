$ ->
  Data = window.Data = {}
  Data.entries   = new (require 'collection.entries')
  Data.accounts  = new (require 'collection.accounts')

  App  = window.App = {}
  App.config  = (require 'app.config')
  App.loader  = new (require 'app.loader')
  App.router  = new (require 'router.app')
  App.fetcher = new (require 'app.fetcher')

$ ->
  # Fuego!
  App.loader.load
    App.fetcher.fetch()
    .done -> Backbone.history.start()
