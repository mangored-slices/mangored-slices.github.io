define 'view.entry', ->
  r = (role) -> "[role~='#{role}']"

  class EntryView extends Backbone.View
    render: ->
      entry = @options.entry

      @$el.html @template
      klass = entry.typeClass()

      @renderCommon(entry, klass)
      @renderImage(entry)  if klass is 'image'
      this

    renderCommon: (entry, klass) ->
      @$el.addClass "entry-#{klass}"
      @$(r 'text').html entry.get('text')
      @$(r 'date_ago').html entry.dateAgo()

    renderImage: (entry) ->
      @$(r 'image').append $("<img>").attr(src: entry.get('image'))

    template: """
      <div class='image' role='image'>
      </div>
      <div class='text' role='text'></div>
      <div class='date' role='date_ago'></div>
    """

