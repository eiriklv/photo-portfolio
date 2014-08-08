define ['isotope'], (Isotope) ->
  
  ###

  Add Isotope or Masonry tiles to component using @refs.tiles

  ###
  Tiles =
    
    tiles: null

    componentDidMount: ->
      unless @tiles?
        @tiles = new Isotope @refs.tiles.getDOMNode(),
          item_selector: '.tile'

    componentDidUpdate: ->
      if @tiles?
        @tiles.reloadItems()
        # Not sure this is necessary for Isotope as opposed to Masonry
        @tiles.layout()
        # This is not necessary when using Masonry, but must be for Isotope
        @tiles.arrange()

    componentWillUnmount: ->
      if @tiles?
        @tiles.destroy()