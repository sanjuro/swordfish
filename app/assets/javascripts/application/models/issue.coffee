class App.Models.Issue extends App.Model
  url: '/issues'

  defaults:
  	assignee: "None"
  	client: "None"
  	priority: "None"
  	priority_color: ''
  	category: "None"
  	category_color: ''

  initialize: ->
  	@assignee = new App.Models.Assignee({model: @get('assignee')})

  client: ->
    if @get('client')?
    	@get('client')
    else
      "None"

  priority: ->
    if @get('priority')?
    	@get('priority')
    else
      "None"

  catgeory: ->
    if @get('catgeory')?
    	@get('catgeory')
    else
      "None"

  validate: (attrs) ->
    errors = []
    if !attrs.title
      errors.push
        name: 'title'
        message: 'Please fill title field.'
    if !attrs.body
      errors.push
        name: 'body'
        message: 'Please fill body field.'
    if errors.length > 0 then errors else false

