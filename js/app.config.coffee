define 'app.config', ->
  isLocal = location.hostname.match(/localhost/)

  Config =
    feedUrl: if isLocal then 'sample' else $("[rel='feedscout_url']").attr('href')

