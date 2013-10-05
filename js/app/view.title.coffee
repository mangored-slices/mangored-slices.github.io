define 'view.title', ->
  r = (role) -> "[role~='#{role}']"

  monitor = require 'lib.scrollmonitor'

  class TitleView extends Backbone.View
    el: $(r 'title_view')
    events:
      'click .jump': 'jump'

    minHeight: 100

    render: ->
      $(window).on 'resize.titleview', @update

      @update()
      @getMonitor()

      this

    ###* Scrolls beyond the title view
    ###
    jump: ->
      $('body').animate scrollTop: @height()+1

    ###* Updates the height of the view
    ###
    update: =>
      @$el.css height: @height()

    ###* Returns the expected height of the view
    ###
    height: ->
      Math.max(@minHeight, $(window).height())

    ###* Returns the scrollmonitor instance that monitors for enter/exit
    ###
    getMonitor: =>
      return unless $('html').is('.desktop')

      timer = null
      @monitor = monitor
        if: (y) =>
          y < @$el.outerHeight()

        enter: (y) =>
          @pinHeight()
          $('html').addClass 'pinned'
          timer = setInterval @pinHeight, 5000

        exit: (y) =>
          $('html').removeClass 'pinned'
          $('html').css height: 'auto'

          clearInterval(timer) if timer
          height = @$el.outerHeight()
          @remove()
          @monitor.disable()
          $(window).scrollTop (y - height)

    ###* "Fixes" the height of the document
    ###
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
