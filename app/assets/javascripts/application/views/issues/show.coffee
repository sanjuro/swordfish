class App.Views.Issues.Show extends App.View
  template: JST["application/templates/issues/issue"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    @$el.html(@template(@model.toJSON()))
    return this