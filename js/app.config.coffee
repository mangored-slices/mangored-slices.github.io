define 'app.config', ->
  isLocal = location.hostname.match(/localhost/)

  Config =
    feedUrl: if isLocal then 'sample' else 'http://slices-feeds.herokuapp.com'

