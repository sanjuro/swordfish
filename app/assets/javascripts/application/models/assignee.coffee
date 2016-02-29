class App.Models.Assignee extends App.Model

  initialize: ->
    if @get('login')?
      @get('login')
    else
      "None"