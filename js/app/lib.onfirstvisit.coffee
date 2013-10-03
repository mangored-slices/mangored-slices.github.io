define 'lib.onfirstvisit', ->
  ###*
  * Runs something on the first visit.
  *
  *     onFirstVisit
  *       days: 7
  *       then: -> alert('welcome!')
  *       else: -> alert('welcome back!')
  ###

  onFirstVisit = (options) ->
    if !$.cookie('hide_title') or location.hash is '#welcome'
      options.else?()
    else
      options.then?()

    $.cookie 'hide_title', '1', expires: options.days
