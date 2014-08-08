define [], ->
  
  ###

  A basic one-way bind for storing Backbone models and collections inside
  of React components. Will attach itself to 'collection' and 'model' properties
  if they have been passed, and add event handlers to do a forceUpdate() every time
  the model/collection changes or syncs.

  When the component unmounts, the notification events will be removed from the Backbone
  collection, guaranteeing proper cleanup and avoiding closure leak.

  ###
  ReactBackbone =
    componentWillMount: ->
      # We need to save the forceUpdate
      # call into a single closure, which can be
      # reliably identified when we want to pass it
      # to Backbone.Events#off().
      #
      # Note that @forceUpdate.bind(@) does NOT work
      # in this case, we have to use an explicit _that
      # that CoffeeScript provides.
      @forceUpdateBoundToSelf_ = (=> @forceUpdate())

  # When the component mounts, start
  # listening to changes on the BB items
    componentDidMount: ->
      for m in _.compact @listenFor()
        if m.on
          for eventName in ['remove', 'add', 'change', 'sync']
            m.on eventName, @forceUpdateBoundToSelf_
        else
          throw "The object passed in `model' or `collection` prop has no on() method"

  #... and when it leaves, stop doing that
    componentWillUnmount: ->
      for m in _.compact @listenFor()
        m.off null, @forceUpdateBoundToSelf_ # Null as first arg. removes all handlers

    listenForCache: null
    listenFor: ->
      return @listenForCache if @listenForCache?
      listenFor = [@props.collection, @props.model]
      if @extraBackboneCollections?
        listenFor.push(@props[prop]) for prop in @extraBackboneCollections
      @listenForCache = listenFor