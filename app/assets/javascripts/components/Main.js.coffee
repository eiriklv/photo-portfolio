define ['react'], (React) ->

  {div} = React.DOM

  React.createClass
    displayName: 'MainViewComponent'
    render: ->
      div {}, 'Hello World!'