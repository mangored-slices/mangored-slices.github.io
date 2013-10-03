define 'app.config', ->
  isLocal = location.hostname.match(/localhost/)

  Config =
    local: isLocal
    feedUrl: if isLocal then 'sample' else $("[rel='feedscout_url']").attr('href')

