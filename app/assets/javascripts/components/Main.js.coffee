define ['react', 'HeaderComponent', 'ContentComponent', 'FooterComponent', 'TelegraphMixin'], (React, HeaderComponent, ContentComponent, FooterComponent, TelegraphMixin) ->

  {div} = React.DOM

  React.createClass
    displayName: 'MainComponent'
    mixins: [TelegraphMixin]

    getDefaultProps: ->
      albums: {}
      cams: {}
      lenses: {}

    componentWillMount: ->
      @on 'menu:change', (e) =>
        @refs.content.setState activeContent: e.url

      @on 'albums:change', (e) =>
        Current.albumId = e.id
        @refs.content.filterPhotosByAlbumId e.id

      @on 'menu:ready', ->
        Current.Router.getOnceNavigationOption 'menuName', (url) =>
          @refs.header.upstream 'menu:change', {url: url}

      @on 'albums:ready', ->
        Current.Router.getOnceNavigationOption 'albumId', (id) =>
          @refs.header.albums().upstream 'albums:change', {id: id}

      @on 'photos:ready', ->
        Current.Router.getOnceNavigationOption 'photoId', (id) =>
          @refs.content.photos().upstream 'photos:change', {id: id}

    componentDidMount: ->
      Current.mainNavigator = @mainNavigator

    componentWillUnmount: ->
      Current.mainNavigator = null
    
    mainNavigator: (n) ->
      @refs.header.upstream 'menu:change', {url: n.menuUrl}
      @refs.header.albums().upstream 'albums:change', {id: n.albumId}
      @refs.content.photos().upstream 'photos:change', {id: n.photoId}

    render: ->
      div {className: 'wrapper'},
        HeaderComponent
          ref: 'header'
          albums: @props.albums
        ContentComponent
          ref: 'content'
          photos: @props.photos
          cams: @props.cams
          lenses: @props.lenses
        FooterComponent()