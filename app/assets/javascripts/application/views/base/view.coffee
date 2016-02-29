class App.View extends Backbone.View

  close: ->
    @unbind()
    @undelegateEvents()

  flashMessage: (type, msg) ->
    title = if type is "success" then "Success" else "Error"
    $.gritter.add({
      title: title
      text: msg
      sticky: false
      time: if type is "success" then 3000 else 8000
    })

  flashSuccessMessage: (msg) ->
    @flashMessage('success', msg)
      
  flashErrorMessage: (msg) ->
    @flashMessage('alert', msg)

  showErrors: (errors) ->
    _.each errors, ((error) ->
      $.gritter.add({
        title: "Error"
        text: error.message
        sticky: false
        time: 4000
      })
    )