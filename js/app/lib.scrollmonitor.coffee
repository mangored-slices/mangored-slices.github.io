define 'lib.scrollmonitor', ->

  ###
  # Monitors scrolling and executes something on different breakpoints.
  #
  # monitor
  #   if: (y) -> y < 300
  #   enter: -> $('top').hide()
  #   exit: -> $('top').show()
  #   scroll: ->
  #
  ###

  (options) ->
    last = null
    $window = $(window)

    # Build the callback
    update = ->
      y = $window.scrollTop()
      now = options.if(y)

      if last isnt now
        last = now

        if now and options.enter
          options.enter(y)
        else if !now and options.exit
          options.exit(y)

      if options.scroll
        options.scroll(y, now)

    # Bind it
    obj =
      update: update
      status: ->
        last
      enable: ->
        $window.on 'resize', update
        $window.on 'scroll', update
        @update()
        this
      disable: ->
        $window.off 'resize', update
        $window.off 'scroll', update
        this

    obj.enable()
