class App.Routers.Issues extends App.Router

  initialize: (options) ->
    @issues = new App.Collections.Issues()
    @issues.reset options.issues

  routes:
    "index"       : "index"
    "new"         : "newIssue"
    ".*"          : "index"
    
  index: ->
    @view = new App.Views.Issues.Index({collection: @issues})

  newIssue: ->
    @view = new App.Views.Issues.New({collection: @issues})