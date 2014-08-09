define ['jquery', 'react', 'MainComponent', 'AlbumsCollection', 'PhotosCollection', 'CamsCollection', 'LensesCollection', 'BackboneRouter'], ($, React, MainComponent, AlbumsCollection, PhotosCollection, CamsCollection, LensesCollection, BackboneRouter) ->
  
  class Frontend
    constructor: ->
      
      window.Current = {}

      Current.Router = new BackboneRouter
      Current.Router.startListening()

      Current.Main = MainComponent
        albums: new AlbumsCollection [], {}
        photos: new PhotosCollection [], {}
        cams: new CamsCollection [], {}
        lenses: new LensesCollection [], {}
      
      Current.reactRoot = document.getElementById 'reactRoot'
      React.renderComponent Current.Main, reactRoot