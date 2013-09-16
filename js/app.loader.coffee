###*
* Provides an interface to show and hide the loader.
###

define 'app.loader', ->
  class Loader

    ###*
    * Loader.
    *
    * Starts a loader, and ends it when the given `promise` is
    resolved.
    ###

    load: (promise) ->
      NProgress.start()
      promise.always -> NProgress.done()

