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

      @$el.find(r 'image').attr
        src: (@model.get('image_large') or @model.get('image'))
        width: width
        height: width * parseFloat(@model.get('image_ratio'), 10)

      @$el.find(r 'title')
        .text(@model.toString())

      @$el.find(r 'date')
        .text(@model.date('ago'))

      @dialog
        .on('close', -> history.back())
        .reposition()

      this

    template: """
      <div>
        <button class='close' role='close'></button>
        <div class='image'>
          <img src='' role='image'>
        </div>
        <div class='meta'>
          <div class='right' role='date'>
          </div>
          <div class='left' role='title'>
          </div>
        </div>
      </div>
    """

