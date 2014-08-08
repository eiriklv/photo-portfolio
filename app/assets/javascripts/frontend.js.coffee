define ['jquery', 'react', 'MainComponent', 'AlbumsCollection', 'PhotosCollection', 'CamsCollection', 'LensesCollection', 'BackboneRouter'], ($, React, MainComponent, AlbumsCollection, PhotosCollection, CamsCollection, LensesCollection, BackboneRouter) ->
  
  class Frontend
    constructor: ->
      
        $('link[rel="stylesheet"]').each ->
          $me = $(this)
          src = $me.attr 'href'
          setInterval ->
            newSrc = "#{src}&r=#{Math.random()}"
            $me.attr 'href', newSrc
          , 3000

      window.Router = new BackboneRouter
      window.Router.startListening()
      
      mainComponent = MainComponent
        albums: new AlbumsCollection [], {}
        photos: new PhotosCollection [], {}
        cams: new CamsCollection [], {}
        lenses: new LensesCollection [], {}
      
      reactRoot = document.getElementById 'reactRoot'
      React.renderComponent mainComponent, reactRoot