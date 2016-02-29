class App.Views.Issues.New extends App.View
  el: '#issues'

  template: JST["application/templates/issues/new"]

  events:
    'click .submit-form' : 'submit'

  initialize: (options) ->
    @$el.append('<div class="loading"></div>').fadeIn();
    @labels = options["labels"] if options["labels"]?
    @labels.fetch success: =>
      @$el.find('.loading').remove()
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

  submit: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @$el.append('<div class="loading"></div>').fadeIn();

    issue_params = 
      title: $('#title').val()
      body: $('#body').val()
      client: $('#client').val()
      category: $('#category').val()
      priority: $('#priority').val()

    model = new App.Models.Issue(issue_params)
    errors = model.validate(issue_params)
    @showErrors errors

    @collection.create model,
      success: (issues) =>
        @flashSuccessMessage('New issue created')
        @close()
        router = new App.Routers.Issues(issues)
        router.navigate('index', {trigger: true}); 
      error: (model, response) =>
        @flashErrorMessage('There was an error creating your issue')
      complete: =>
        @$el.find('.loading').remove()

  get_option_type: (type) ->
     _.filter @labels.toJSON(), (option) -> option.type == type
