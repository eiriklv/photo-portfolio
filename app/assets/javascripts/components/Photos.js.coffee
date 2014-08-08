define ['react', 'ReactBackboneMixin', 'TilesMixin'], (React, ReactBackboneMixin, TilesMixin) ->

  {div, img} = React.DOM
  cx = React.addons.classSet

  p = console.log.bind console

  PhotoComponent = React.createClass
    displayName: 'PhotoComponent'
    
    getDefaultProps: ->
      album_id: 0
    
    getInitialState: ->
      overlayPosition: 'left'
      hover: false
      animate: false
      # thumbLoaded: false
    
    componentDidMount: ->
      image = @refs.thumb.getDOMNode()
      # image.onload = image.onerror = @thumbLoaded
    
    # thumbLoaded: ->
    #   @setState thumbLoaded: true
    
    onMouseEnter: (e) ->
      @setState
        animate: false
        overlayPosition: @detectSide(@refs.me.getDOMNode().getBoundingClientRect(), e.clientX, e.clientY)
      setTimeout =>
        @setState
          hover: true
          animate: true
      , 10
    
    onMouseLeave: (e) ->
      @setState
        overlayPosition: @detectSide(@refs.me.getDOMNode().getBoundingClientRect(), e.clientX, e.clientY)
        animate: false
      setTimeout =>
        @setState
          hover: false
          animate: true
      , 10
    
    detectSide: (rect, mouseX, mouseY) ->
      distance =
        left: Math.abs(rect.left - mouseX)
        right: Math.abs(rect.left + rect.width - mouseX)
        top: Math.abs(rect.top - mouseY)
        bottom: Math.abs(rect.top + rect.height - mouseY)

      minDistance = Math.max(rect.width, rect.height)

      if distance.left < minDistance
        result = 'left'
        minDistance = distance.left

      if distance.right < minDistance
        result = 'right'
        minDistance = distance.right

      if distance.top < minDistance
        result = 'top'
        minDistance = distance.top

      if distance.bottom < minDistance
        result = 'bottom'
        minDistance = distance.bottom

      result
    
    render: ->
      overlayClasses = cx
        overlay: true
        left: @state.overlayPosition is 'left'
        right: @state.overlayPosition is 'right'
        top: @state.overlayPosition is 'top'
        bottom: @state.overlayPosition is 'bottom'
        hover: @state.hover
        animate: @state.animate
      
      div {ref: 'me', className: "tile photo album_#{@props.album_id}", onMouseEnter: @onMouseEnter, onMouseLeave: @onMouseLeave},
        img {ref: 'thumb', className: 'thumb', src: @props.thumb_x2_url}
        div {className: overlayClasses},
          div {className: 'name'}, @props.name
          div {className: 'description'}, @props.description

  React.createClass
    displayName: 'PhotosComponent'
    mixins: [ReactBackboneMixin, TilesMixin]
    
    masonry: null
    
    getDefaultProps: ->
      collection: []

    componentWillMount: ->
      @props.collection.fetch()
    
    filterPhotosByAlbumId: (albumId) ->
      if @tiles?
        @tiles.arrange
          filter: (".album_#{albumId}" if albumId)
    
    render: ->
      photos = @props.collection.map (model) ->
        new PhotoComponent
          key: model.get 'id'
          id: model.get 'id'
          name: model.get 'name'
          description: model.get 'description'
          views: model.get 'views'
          album_id: model.get 'album_id'
          cam_id: model.get 'cam_id'
          lens_id: model.get 'lens_id'
          iso: model.get 'iso'
          aperture: model.get 'aperture'
          exposure: model.get 'exposure'
          focal_distance: model.get 'focal_distance'
          thumb_url: model.get 'thumb_url'
          thumb_x2_url: model.get 'thumb_x2_url'

      div {ref: 'tiles', id: 'photos', className: 'photos'}, photos