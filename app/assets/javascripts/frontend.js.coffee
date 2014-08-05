define ['jquery', 'react', 'MainView'], ($, React, MainView) ->
  
  class Frontend
    constructor: ->
      reactRoot = document.getElementById 'reactRoot'
      React.renderComponent MainView(), reactRoot