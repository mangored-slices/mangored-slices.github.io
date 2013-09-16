define 'app.fetcher', ->
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
        console.log(data)
        Data.accounts.reset data.sources
        Data.entries.reset data.entries

      .then ->
        console.log("[Fetcher] ok")

