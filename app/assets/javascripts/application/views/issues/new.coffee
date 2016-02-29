class App.Views.Issues.New extends App.View
  el: '#issues'

  template: JST["application/templates/issues/new"]

  events:
    'click .submit-form' : 'submit'

  initialize: (options) ->
    @labels = options["labels"] if options["labels"]?
    @labels.fetch success: =>
      @render()

  render: ->
    params = @renderParams()
    $(@el).html(@template(params))
    return this

  renderParams: ->
    client_options: _.map @get_option_type('client'), (client_option) -> client_option.name
    category_options: _.map @get_option_type('category'), (client_option) -> client_option.name
    priority_options: _.map @get_option_type('priority'), (client_option) -> client_option.name
    issue: @model.toJSON()

  close: ->
    @unbind()
    @undelegateEvents()

  submit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = $('#title').val()
    body = $('#body').val()
    client = $('#client').val()
    category = $('#category').val()
    priority = $('#priority').val()
    model = new App.Models.Issue({title: title, body: body, client: client, category: category, priority: priority})

    @collection.create model,
      success: (issues) =>
        alert('New issue created')
        @close()
        router = new App.Routers.Issues(issues)
        router.navigate('index', {trigger: true}); 

      error: (model, response) =>
        alert(response.message)

  get_option_type: (type) ->
     _.filter @labels.toJSON(), (option) -> option.type == type