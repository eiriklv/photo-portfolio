define ['react', 'HeaderComponent', 'ContentComponent', 'FooterComponent', 'TelegraphMixin'], (React, HeaderComponent, ContentComponent, FooterComponent, TelegraphMixin) ->

  {div} = React.DOM

  p = console.log.bind console

  React.createClass
    displayName: 'MainComponent'
    mixins: [TelegraphMixin]

    getDefaultProps: ->
      albums: {}
      cams: {}
      lenses: {}

    componentWillMount: ->
      @on 'menu:change', (e) =>
        @refs.content.setState activeContent: e.name

      @on 'albums:change', (e) =>
        @refs.content.filterPhotosByAlbumId e.id

    render: ->
      div {className: 'wrapper'},
        HeaderComponent
          albums: @props.albums
        ContentComponent
          ref: 'content'
          photos: @props.photos
          cams: @props.cams
          lenses: @props.lenses
        FooterComponent()