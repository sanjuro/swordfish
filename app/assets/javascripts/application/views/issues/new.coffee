class App.Views.Issues.New extends App.View
  el: '#issues'

  template: JST["application/templates/issues/new"]

  events:
    "submit #new-issue": "save"

  initialize: ->
    @render()

  renderParams: ->
    console.log(App.Labels.toJSON());
    client_options: _.map @get_option_type('client'), (client_option) -> client_option.name
    category_options: _.map @get_option_type('category'), (client_option) -> client_option.name
    priority_options: _.map @get_option_type('priority'), (client_option) -> client_option.name
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

  get_option_type: (type) ->
     _.filter App.Labels.toJSON(), (option) -> option.type == type