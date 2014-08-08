define ['react', 'PhotosComponent'], (React, PhotosComponent) ->

  {div} = React.DOM

  p = console.log.bind console

  React.createClass
    displayName: 'ContentComponent'

    getDefaultProps: ->
      photos: []

    getInitialState: ->
      activeContent: null

    filterPhotosByAlbumId: (albumId) ->
      if @refs? and @refs.photos?
        @refs.photos.filterPhotosByAlbumId albumId

    render: ->
      if @state.activeContent?
        activeContent = switch @state.activeContent
          when 'Photos' then new PhotosComponent
            ref: 'photos'
            collection: @props.photos
          else null
      div {className: 'content'}, (activeContent if activeContent?)