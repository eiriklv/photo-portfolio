define ['jquery', 'react', 'MainComponent', 'AlbumsCollection', 'PhotosCollection', 'CamsCollection', 'LensesCollection', 'BackboneRouter'], ($, React, MainComponent, AlbumsCollection, PhotosCollection, CamsCollection, LensesCollection, BackboneRouter) ->
  
  class Frontend
    constructor: ->
      
      window.Current = {}
      
      window.fbAsyncInit = ->
        FB.init
          appId: '466800570010174',
          xfbml: true,
          version: 'v2.0'
        FB.getLoginStatus ->

      fbFN = (d, s, id) ->
        fjs = d.getElementsByTagName(s)[0]
        return if d.getElementById(id)
        js = d.createElement(s)
        js.id = id
        js.src = "//connect.facebook.net/en_US/sdk.js"
        fjs.parentNode.insertBefore(js, fjs)
      fbFN(document, 'script', 'facebook-jssdk')

      Current.Router = new BackboneRouter
      Current.Router.startListening()

      Current.Main = MainComponent
        albums: new AlbumsCollection [], {}
        photos: new PhotosCollection [], {}
        cams: new CamsCollection [], {}
        lenses: new LensesCollection [], {}
      
      Current.reactRoot = document.getElementById 'reactRoot'
      React.renderComponent Current.Main, reactRoot