define ['react', 'ReactBackboneMixin', 'TelegraphMixin'], (React, ReactBackboneMixin, TelegraphMixin) ->

  {div, a, ul, li} = React.DOM
  cx = React.addons.classSet

  AlbumComponent = React.createClass
    displayName: 'AlbumComponent'
    mixins: [TelegraphMixin]

    getInitialState: ->
      active: false

    clickHandler: ->
      @upstream 'albums:change', {id: @props.id}
      Current.Router.navigate "photo/#{@props.id or 'all'}"

    clickCallback: (selectedId) ->
      @setState active: @props.id is selectedId

    render: ->
      classes = cx
        active: @state.active

      li {}, a {className: classes, onClick: @clickHandler}, @props.name

  AlbumsComponent = React.createClass
    displayName: 'AlbumsComponent'
    mixins: [ReactBackboneMixin, TelegraphMixin]
    
    getDefaultProps: ->
      collection: []
      visible: false
    
    componentWillMount: ->
      @props.collection.fetch
        success: =>
          @upstream 'albums:ready'
      @on 'albums:change', (e) =>
        if @refs?
          for key, album of @refs
            album.clickCallback e.id
    
    render: ->
      albums = @props.collection.map (model) ->
        AlbumComponent
          ref: "album_#{model.get('id')}"
          key: model.get 'id'
          id: model.get 'id'
          name: model.get 'name'
          position: model.get 'position'
      
      albums.unshift AlbumComponent
        ref: "album_0"
        key: 0
        id: 0
        name: 'All'
        position: '9999'
      
      classes = cx
        albums: true
        visible: @props.visible
      
      ul {className: classes}, albums

  MenuItemComponent = React.createClass
    displayName: 'MenuItemComponent'
    mixins: [TelegraphMixin]
    
    getDefaultProps: ->
      name: ''
      url: ''
    
    getInitialState: ->
      active: false

    clickHandler: ->
      @upstream 'menu:change', {url: @props.url}
      Current.Router.navigate @props.url

    clickCallback: (selectedURL) ->
      @setState active: @props.url is selectedURL

    render: ->
      classes = cx
        active: @state.active
      
      li {},
        a {className: classes, onClick: @clickHandler}, @props.name

  React.createClass
    displayName: 'HeaderComponent'
    mixins: [TelegraphMixin]

    getDefaultProps: ->
      albums: []
    
    getInitialState: ->
      activePage: null

    componentWillMount: ->
      @on 'menu:change', (e) =>
        @setState activePage: e.url
        if @refs?
          for key in [1..3]
            menuItem = @refs["menu_#{key}"]
            if menuItem?
              menuItem.clickCallback e.url
        @refs.albums.upstream 'albums:change', {id: 0} if e.url is 'photo'

    componentDidMount: ->
      @upstream 'menu:ready'

    onLogoClick: ->
      @upstream 'menu:change', {url: 'photo'}
      @refs.albums.upstream 'albums:change', {id: 0}
      Current.Router.navigate 'photo'

    albums: ->
      @refs.albums

    render: ->
      div {className: 'header'},
        a {className: 'logo', onClick: @onLogoClick}, 'Karén'
        ul {className: 'menu'},
          MenuItemComponent
            ref: 'menu_1'
            name: 'Photos'
            url: 'photo'
          MenuItemComponent
            ref: 'menu_2'
            name: 'About'
            url: 'about'
          MenuItemComponent
            ref: 'menu_3'
            name: 'Contact'
            url: 'contact'
        AlbumsComponent
          ref: 'albums'
          collection: @props.albums
          visible: @state.activePage is 'photo'
