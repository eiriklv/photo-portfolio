define ['react', 'ReactBackboneMixin', 'TelegraphMixin'], (React, ReactBackboneMixin, TelegraphMixin) ->

  {div, a, ul, li} = React.DOM
  cx = React.addons.classSet

  AlbumComponent = React.createClass
    displayName: 'AlbumComponent'
    mixins: [TelegraphMixin]

    getInitialState: ->
      active: false

    componentDidMount: ->
      if window.Router.navigation.albumId? and (parseInt(@props.id) is parseInt(window.Router.navigation.albumId) or (@props.id is 0 and window.Router.navigation.albumId is 'all'))
        window.Router.navigation.albumId = null
        @clickHandler()

    clickHandler: ->
      @upstream 'albums:change', {id: @props.id}
      window.Router.navigate "photo/#{@props.id or 'all'}"

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
      @props.collection.fetch()
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

    componentDidMount: ->
      if window.Router.navigation.menuName? and @props.url is window.Router.navigation.menuName
        window.Router.navigation.menuName = null
        @clickHandler()

    clickHandler: ->
      @upstream 'menu:change', {name: @props.name}
      window.Router.navigate @props.url

    clickCallback: (selectedName) ->
      @setState active: @props.name is selectedName

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
        @setState activePage: e.name
        if @refs?
          for key, menuItem of @refs
            menuItem.clickCallback e.name

    onLogoClick: ->
      @upstream 'menu:change', {name: 'Photos'}
      window.Router.navigate 'photo'

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
          collection: @props.albums
          visible: @state.activePage is 'Photos'