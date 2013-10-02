define 'view.entry_dialog', ->
  r = (role) -> "[role~='#{role}']"

  class EntryDialogView
    constructor: (options={}) ->
      @model = options.model

    render: ->
      @dialog = NDialog.open
        html: @template
        class: 'entry-dialog'

      width = 600

      @$el = @dialog.$el
      @$el.find(r 'image').attr src: (@model.get('image_large') or @model.get('image'))
      @$el.find(r 'title').text @model.toString()
      @$el.find(r 'date').text @model.date('ago')
      @$el.find(r 'image')
        .attr(width: width)
        .attr(height: width * parseFloat(@model.get('image_ratio'), 10))

      @dialog.reposition()

      this

    template: """
      <div>
        <div class='image'>
          <img src='' role='image'>
        </div>
        <div class='meta'>
          <div class='left' role='title'>
          </div>
          <div class='right' role='date'>
          </div>
        </div>
      </div>
    """

