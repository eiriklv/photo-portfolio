define ['react'], (React) ->

  {div, span, a} = React.DOM

  React.createClass
    displayName: 'FooterComponent'

    render: ->
      div {className: 'footer'},
        span {}, '© 2014 '
        a {href: 'mailto:photo@karenishe.com'}, 'Karén'
        span {}, ' – All rights reserved'