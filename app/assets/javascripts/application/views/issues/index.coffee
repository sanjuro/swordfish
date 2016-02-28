class App.Views.Issues.Index extends App.View
  el: '#issues'

  template: JST["application/templates/issues/index"]

  initialize: ->
    @render()
    @addAll()

  addAll: ->
    @collection.forEach(@addOne, @)

  addOne: (model) ->
    @view = new App.Views.Issues.Show({model: model})
    @$el.find('tbody').append @view.render().el

  render: ->
    @$el.html @template()