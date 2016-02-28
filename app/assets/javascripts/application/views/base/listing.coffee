class App.View.Listing extends App.View
  listHolderSelector: 'collection-holder'
  listItems: []
  visibleListItems: []

  listElement: ->
    @$("##{@listHolderSelector}")

  removeListItems: ->
    @listItems = []
    @listElement().children().remove()

  renderCollection: =>
    @removeListItems()

    if @listSeparatorTemplate?
      @collection.each (model) => @renderModel(model)
      @afterRenderCollection() if @afterRenderCollection
    else
      @collection.each (model) => @addListItem(@createModelView(model))
      @renderFilteredCollection(@listItems)

  collectionFetchParams: ->
    {}

  fetchCollection: ->
    return if @collection.url is ''
    
    @collection.fetch(
      data: $.param(@collectionFetchParams())
      success: =>
        @renderCollection()
    )