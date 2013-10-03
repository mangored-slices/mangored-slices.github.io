define 'view.entry', ->
  r = (role) -> "[role~='#{role}']"

  class EntryView extends Backbone.View

    tagName: 'article'
    className: 'entry-item'

    initialize: ->
      @entry = @options.entry
      @index = @options.index

    ###* Renders the element
    ###

    render: ->
      @$el.html @template

      @renderClasses()
      @renderCommon()
      @renderSize()
      @renderImage()  if @entry.isImage()

      this

    ###* Adds CSS classes
    ###
    renderClasses: ->
      @$el.addClass "entry-#{@entry.typeClass()}"
      @$el.addClass "service-#{@entry.source().name}"
      @$el.addClass "text-#{@getLength()}"

    ###* Renders common entries
    ###
    renderCommon: ->
      @$el.attr 'role', 'entry'
      @$(r 'link').attr href: "#e/#{@entry.slug()}"
      @$(r 'text').html @entry.get('text')
      @$(r 'date').html @entry.date('long')
      @$(r 'date_ago').html @entry.date('ago')

    ###* Updates size classes (.w-1.h-2)
    ###
    renderSize: ->
      [w, h] = @getSize()
      @$el.addClass "w#{w} h#{h}"

    ###* Returns grid size as a tuple (`[1, 3]` for 1x3)
    ###
    getSize: ->
      if @index is 0
        [2, 2]
      else if @entry.isImage()
        if @entry.isVertical()
          [1, 2]
        else if @entry.isHorizontal()
          [2, 1]
        else if Math.random() < 0.4
          [2, 2]
        else
          [1, 1]
      else
        [1, 1]

    ###* Returns the length
    ###
    getLength: ->
      len = @entry.get('text').length
      if len <= 60
        'short'
      else if len <= 110
        'medium'
      else if len <= 180
        'long'
      else
        'xlong'

    ###* Renders an image type
    ###
    renderImage: ->
      src = @entry.get('image')
      if src
        @$(r 'image').append $("<img>").attr(src: src)
        @$(r 'image').fillsize("> img")

    ###* HTML template
    ###

    template: """
      <a class='link' href='#' role='link'></a>
      <div class='image' role='image'>
      </div>
      <div class='meta'>
        <div>
          <div class='date' role='date'></div>
          <div class='text' role='text'></div>
          <div class='date-ago' role='date_ago'></div>
        </div>
      </div>
    """

