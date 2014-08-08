define ['react', 'PhotosComponent', 'PhotoLargeComponent', 'TelegraphMixin'], (React, PhotosComponent, PhotoLargeComponent, TelegraphMixin) ->

  {div} = React.DOM

  p = console.log.bind console

  React.createClass
    displayName: 'ContentComponent'
    mixins: [TelegraphMixin]

    albumId: null

    getDefaultProps: ->
      photos: {}
      cams: {}
      lenses: {}

    getInitialState: ->
      activeContent: null
      selectedPhotoId: null

    componentDidMount: ->
      @on 'photo:change', (e) =>
        if e.id
          @setState
            activeContent: 'PhotoLarge'
            selectedPhotoId: e.id
      
      @on 'photoLarge:close', =>
        @setState
          activeContent: 'Photos'
          selectedPhotoId: null

      @on 'photoLarge:prev', =>
        photos = @props.photos
        photos = photos.byAlbumId @albumId if @albumId
        newIndex = photos.indexOf(photos.get(@state.selectedPhotoId)) - 1
        newIndex = photos.length - 1 if newIndex < 0
        @setState selectedPhotoId: photos.at(newIndex).get('id')

      @on 'photoLarge:next', =>
        photos = @props.photos
        photos = photos.byAlbumId @albumId if @albumId
        newIndex = photos.indexOf(photos.get(@state.selectedPhotoId)) + 1
        newIndex = 0 if newIndex >= photos.length
        @setState selectedPhotoId: photos.at(newIndex).get('id')

    filterPhotosByAlbumId: (albumId) ->
      if @refs? and @refs.photos?
        @albumId = albumId
        @refs.photos.filterPhotosByAlbumId albumId

    render: ->
      if @state.activeContent?
        activeContent = switch @state.activeContent
          when 'Photos' then new PhotosComponent
            ref: 'photos'
            collection: @props.photos
            defaultAlbumId: @albumId
          when 'PhotoLarge' then new PhotoLargeComponent
            ref: 'photoLarge'
            model: @props.photos.get @state.selectedPhotoId
            cams: @props.cams
            lenses: @props.lenses
          else null
      div {className: 'content'}, (activeContent if activeContent?)