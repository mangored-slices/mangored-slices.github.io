define 'view.entry', ->
  r = (role) -> "[role~='#{role}']"

  class EntryView extends Backbone.View

    tagName: 'article'
    className: 'entry-item'

    ###* Renders the element
    ###

    render: ->
      entry = @options.entry

      @$el.html @template
      klass = entry.typeClass()

      @renderClasses(entry, klass)
      @renderCommon(entry)
      @renderImage(entry)  if klass is 'image'

      this

    ###* Adds CSS classes
    ###

    renderClasses: (entry, klass) ->
      @$el.addClass "entry-#{klass}"
      @$el.addClass "service-#{entry.source().name}"

    ###* Renders common entries
    ###

    renderCommon: (entry) ->
      @$(r 'text').html entry.get('text')
      @$(r 'date').html entry.date('long')
      @$(r 'date_ago').html entry.date('ago')

    ###* Renders an image type
    ###

    renderImage: (entry) ->
      @$(r 'image').append $("<img>").attr(src: entry.get('image'))

    ###* HTML template
    ###

    template: """
      <a class='link' href='#'></a>
      <div class='image' role='image'>
      </div>
      <div class='meta'>
        <div class='date' role='date'></div>
        <div class='text' role='text'></div>
        <div class='date-ago' role='date_ago'></div>
      </div>
    """

