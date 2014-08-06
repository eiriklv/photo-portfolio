define [], ->

  # A module that allows us to send Backbone events up the tree of components
  async = ((cb) -> cb())

  ReactTelegraph =
    componentWillMount: ->
      # Make BB events available to the component
      _.extend @, Backbone.Events
  
    componentWillUnmount: ->
      # Remove all Backbone event listeners
      @off null, null, null
  
    # Trigger a backbone event on myself and all of my parents and grandparents
    # that support upstream()
    upstream: (ar...) ->
      # Trigger the event on myself using partial application.
      async =>
        try
          @trigger.bind(@, ar...)()
        catch e
          # Do not propagate it to my parent or to the passed event bus
          # if an error is thrown during event handling.
          console.error "Error in trigger() during upstream('#{ar[0]}'): #{e.message}"
          return
    
      # Telegraph the event up the component tree
      parent = @_owner
    
      # Only do this if the owner component responds to "upstream"
      # - the extension indicates that the component participates in the 
      # Telegraph system and has the mixin
      if parent and parent.upstream
        parent.upstream(ar...)
      else if @props and @props.eventBus
        # Telegraph the event to the passed "event bus"
        async @props.eventBus.trigger.bind(@props.eventBus, ar...)
      else
        # console.log "No eventBus prop or parent component, telegram delivered"
        true