define 'view.entry', ->
  class EntryView extends Backbone.View
    render: ->
      entry = @options.entry

      @$el.html "Entry: #{entry.get('text')}"
      this
