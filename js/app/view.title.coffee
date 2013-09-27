define 'view.title', ->
  r = (role) -> "[role~='#{role}']"

  monitor = require 'lib.scrollmonitor'

  class TitleView extends Backbone.View
    el: $(r 'title_view')

    minHeight: 100

    render: ->
      $(window).on 'resize.titleview', @update

      @update()
      @monitor = @getMonitor()

      this

    height: ->
      Math.max(@minHeight, $(window).height())

    update: =>
      @$el.css height: @height()

    getMonitor: =>
      timer = null
      @monitor = monitor
        if: (y) =>
          y < @$el.outerHeight()

        enter: (y) =>
          @pinHeight()
          $('html').addClass 'pinned'
          timer = setInterval @pinHeight, 1500

        exit: (y) =>
          $('html').removeClass 'pinned'
          clearInterval(timer) if timer
          height = @$el.outerHeight()
          @remove()
          @monitor.disable()
          $(window).scrollTop (y - height)

    pinHeight: =>
      pinned = $('html').is('.pinned')

      if pinned
        $('html').removeClass('pinned')
        $('html').outerHeight

      h = $(document).height()

      if pinned
        $('html').addClass('pinned')
        $('html').outerHeight

      $('html').css height: h
      h
