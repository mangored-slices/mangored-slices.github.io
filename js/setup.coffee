# Initialize `Data` object to be filled by App.loader.
$ ->
  Data = window.Data = {}
  Data.entries   = new (require 'collection.entries')
  Data.accounts  = new (require 'collection.accounts')

# Initialize App.
$ ->
  App  = window.App = {}
  App.nav     = (url) -> Backbone.history.navigate url, trigger: true
  App.config  = (require 'app.config')
  App.loader  = new (require 'app.loader')
  App.router  = new (require 'router.app')
  App.fetcher = new (require 'app.fetcher')
  App.listView = new (require 'view.list')().render()
  App.menuView = new (require 'view.menu')

# Initialize 'mobile/desktop' classname'
$ ->
  isMobile = navigator.userAgent.match(/iPod|iPad|iPhone|Android/)
  $('html').addClass if isMobile then 'mobile' else 'desktop'

# Initialize titleView
$ ->
  onFirstVisit = require 'lib.onfirstvisit'
  onFirstVisit
    days: 7
    then: =>
      $('[role~="title_view"]').remove()
    else: =>
      App.titleView = new (require 'view.title')().render()

# Timeout for webfont loader
do ->
  setTimeout ->
    if !$('html').is('.wf-active') and !$('html').is('.wf-inactive')
        $('html').addClass('wf-inactive')
  , 10000

# Load data and do stuff
$ ->
  App.loader.load(
    App.fetcher.fetch()
    .done ->
      $('html').addClass('loaded')
      Backbone.history.start()
  )
