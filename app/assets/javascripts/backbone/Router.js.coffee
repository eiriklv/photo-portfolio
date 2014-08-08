define ['backbone'], (Backbone) ->
  Backbone.Router.extend
    startListening: ->
      # Start the router
      Backbone.history.start pushState: true, root: '/'

    # Override Router#navigate to force our routing state
    # without the address bar and history features if they are not
    # supported, as opposed to switching over to anchors
    navigate: (url, options)->
      # For good browsers simply use the built-in facilities
      if window.history && window.history.pushState
        # http://www.webdeveasy.com/backbone-cleanup/
        Backbone.Router.prototype.navigate.apply(this, arguments) # super
      else
        # For IE < 10 (shit browsers without pushState) 
        # If no pushState is available perform the UI state changes
        # but do nothing to the address bar. Because I so don't care
        # whether the hash changes.
        # So they WILL get the single-page navigation but they won't get the
        # address changes in the address bar
        Backbone.history.loadUrl(url)

    routes:
      'photo': 'photo'
      'photo/:album': 'photo'
      'photo/:album/:photo': 'photo'
      'about': 'about'
      'contact': 'contact'

    navigation:
      menuName: 'photo'
      albumId: 'all'
      photoId: null

    photo: (album, photo) ->
      @navigation.menuName = 'photo'
      @navigation.albumId = album if album?
      @navigation.photoId = photo if photo?

    about: ->
      @navigation.menuName = 'about'

    contact: ->
      @navigation.menuName = 'contact'
      
      