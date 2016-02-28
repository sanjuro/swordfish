class App.Views.Issues.New extends App.View
 el: '#issues'

 template: JST["application/templates/issues/new"]

 events:
   "submit #new-issue": "save"

 initialize: ->
   @render()

 render: ->
   @$el.html @template()

 save: (e) ->
   e.preventDefault()
   e.stopPropagation()
   title = $('#title').val()
   body = $('#body').val()
   model = new App.Models.Issue({title: title, body: body})
   @collection.create model,
        success: (issue) =>
       @model = issue
       window.location.hash = "/#issues"