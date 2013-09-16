define 'app.loader', ->
  ###*
  Provides an interface to show and hide the loader.
  ###

  class Loader

    constructor: ->
      NProgress.configure speed: 100

    ###*
    Loader.
    
    Starts a loader, and ends it when the given `promise` is
    resolved.
    ###

    load: (promise) ->
      NProgress.start()
      promise.always => NProgress.done()
