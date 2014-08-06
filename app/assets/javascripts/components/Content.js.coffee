define ['react', 'PhotosComponent'], (React, PhotosComponent) ->

  {div} = React.DOM

  p = console.log.bind console

  React.createClass
    displayName: 'ContentComponent'

    getDefaultProps: ->
      photos: []

    getInitialState: ->
      activeContent: null

    render: ->
      if @state.activeContent?
        activeContent = switch @state.activeContent
          when 'Photos' then new PhotosComponent {collection: @props.photos}
          else null
      div {className: 'content'}, (activeContent if activeContent?)