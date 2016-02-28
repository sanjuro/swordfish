class App.Models.Label extends App.Model
  url: '/lables'

  name: ->
    if @get('name')?
    	@get('name')
    else
      "None"