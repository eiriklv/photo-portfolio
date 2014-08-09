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

      # FB.Dialog.remove FB.Dialog._active if FB?

    routes:
      '': 'photo'
      'photo': 'photo'
      'photo/:album': 'photo'
      'photo/:album/:photo': 'photo'
      'about': 'about'
      'contact': 'contact'

    navigation:
      menuName: [false, false, 'photo']
      albumId: [false, false, 0]
      photoId: [false, false, null]

    photo: (albumId, photoId) ->
      albumId = parseInt(albumId) or 0
      photoId = parseInt(photoId) or 0
      
      @setOnceNavigationOption 'menuName', 'photo'
      @setOnceNavigationOption 'albumId', albumId
      @setOnceNavigationOption 'photoId', photoId

      if Current.mainNavigator?
        Current.mainNavigator
          menuUrl: 'photo'
          albumId: albumId
          photoId: photoId

    about: ->
      @setOnceNavigationOption 'menuName', 'about'

      if Current.mainNavigator?
        Current.mainNavigator
          menuUrl: 'about'
          albumId: 0
          photoId: 0

    contact: ->
      @setOnceNavigationOption 'menuName', 'contact'

      if Current.mainNavigator?
        Current.mainNavigator
          menuUrl: 'contact'
          albumId: 0
          photoId: 0

    setOnceNavigationOption: (option, value) ->
      unless @navigation[option][0]
        @navigation[option][0] = true
        @navigation[option][2] = value
    
    getOnceNavigationOption: (option, callback) ->
      unless @navigation[option][1]
        @navigation[option][1] = true
        callback @navigation[option][2]