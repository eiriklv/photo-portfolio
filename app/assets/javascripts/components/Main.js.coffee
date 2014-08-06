define ['react', 'HeaderComponent', 'ContentComponent', 'FooterComponent', 'TelegraphMixin'], (React, HeaderComponent, ContentComponent, FooterComponent, TelegraphMixin) ->

  {div} = React.DOM

  p = console.log.bind console

  React.createClass
    displayName: 'MainComponent'
    mixins: [TelegraphMixin]

    getDefaultProps: ->
      albums: []

    componentWillMount: ->
      @on 'menu:change', (e) =>
        @refs.content.setState activeContent: e.name

    render: ->
      div {},
        HeaderComponent
          albums: @props.albums
        ContentComponent
          ref: 'content'
          photos: @props.photos
        FooterComponent()