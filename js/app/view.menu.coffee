define 'view.menu', ->
  r = (role) -> "[role~='#{role}']"

  ###*

  Usage:

      App.menuView.activate('instagram')
      App.menuView.activate(null)
  ###

  class MenuView extends Backbone.View
    el: $(r 'menu')

    activate: (service) ->
      @$('a').removeClass('active')
      @$("a.link-#{service}").addClass('active')  if service
