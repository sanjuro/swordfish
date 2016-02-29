class App.View extends Backbone.View

	closeView: ->
	  @$el.empty()
	  @unbind()