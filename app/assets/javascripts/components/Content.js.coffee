define ['react', 'PhotosComponent', 'PhotoLargeComponent', 'TelegraphMixin', 'AboutComponent', 'ContactComponent'], (React, PhotosComponent, PhotoLargeComponent, TelegraphMixin, AboutComponent, ContactComponent) ->

  {div} = React.DOM

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
        newModel = photos.at(newIndex)
        @setState selectedPhotoId: newModel.get('id')
        window.Router.navigate "photo/#{newModel.get('album_id') or 'all'}/#{newModel.get('id')}"

      @on 'photoLarge:next', =>
        photos = @props.photos
        photos = photos.byAlbumId @albumId if @albumId
        newIndex = photos.indexOf(photos.get(@state.selectedPhotoId)) + 1
        newIndex = 0 if newIndex >= photos.length
        newModel = photos.at(newIndex)
        @setState selectedPhotoId: newModel.get('id')
        window.Router.navigate "photo/#{newModel.get('album_id') or 'all'}/#{newModel.get('id')}"

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
          when 'About' then new AboutComponent
          when 'Contact' then new ContactComponent
          else null
      div {className: 'content'}, (activeContent if activeContent?)