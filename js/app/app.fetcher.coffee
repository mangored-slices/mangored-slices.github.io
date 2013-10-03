define 'app.fetcher', ->
  Config = require 'app.config'

  class Fetcher
    constructor: ->
      @url = App.config.feedUrl
      @entries = Data.entries

    ###*
    * Starts fetching.
    * Returns a Promise object.
    ###

    fetch: ->
      $.get("#{@url}/feed.json")
      .then (data) ->
        # Populate
        Data.accounts.reset data.sources
        Data.entries.reset data.entries

