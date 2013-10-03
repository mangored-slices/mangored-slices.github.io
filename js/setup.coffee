$ ->
  Data = window.Data = {}
  Data.entries   = new (require 'collection.entries')
  Data.accounts  = new (require 'collection.accounts')

  App  = window.App = {}
  App.nav     = (url) -> Backbone.history.navigate url, trigger: true
  App.config  = (require 'app.config')
  App.loader  = new (require 'app.loader')
  App.router  = new (require 'router.app')
  App.fetcher = new (require 'app.fetcher')

$ ->
  isMobile = navigator.userAgent.match(/iPod|iPad|iPhone|Android/)
  $('html').addClass if isMobile then 'mobile' else 'desktop'

  onFirstVisit = require 'lib.onfirstvisit'

  App.listView = new (require 'view.list')().render()
  App.menuView = new (require 'view.menu')

  onFirstVisit
    days: 7
    then: =>
      $('[role~="title_view"]').remove()
    else: =>
      App.titleView = new (require 'view.title')().render()

  # Fuego!
  App.loader.load(
    App.fetcher.fetch()
    .done -> Backbone.history.start()
  )
