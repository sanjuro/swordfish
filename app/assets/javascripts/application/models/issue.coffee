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