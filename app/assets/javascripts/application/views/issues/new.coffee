class App.Views.Issues.New extends App.View
  el: '#issues'

  template: JST["application/templates/issues/new"]

  events:
    "submit #new-issue": "save"

  initialize: ->
    @render()

  renderParams: ->
    console.log(App.Labels)
    client_options: App.Labels
    issue: @model.toJSON()

  render: ->
    params = @renderParams()
    $(@el).html(@template(params))
    return this

 save: (e) ->
  e.preventDefault()
  e.stopPropagation()
  title = $('#title').val()
  body = $('#body').val()
  model = new App.Models.Issue({title: title, body: body, client: client})
  @collection.create model,
    success: (issue) =>
      @model = issue
      window.location.hash = "/#issues"