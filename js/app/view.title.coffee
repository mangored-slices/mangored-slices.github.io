define 'view.title', ->
  r = (role) -> "[role~='#{role}']"

  class TitleView extends Backbone.View
    el: $(r 'title_view')

    minHeight: 100

    render: ->
      $(window).on 'resize.titleview', @update
      @update()
      this

    update: =>
      height = Math.max(@minHeight, $(window).height())
      @$el.css height: height
