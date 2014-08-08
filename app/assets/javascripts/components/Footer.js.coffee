define ['react'], (React) ->

  {div, span, a} = React.DOM

  React.createClass
    displayName: 'FooterComponent'

    getDefaultProps: ->
      years: "2014#{if (currentYear = (new Date).getFullYear()) > 2014 then "–#{currentYear}" else ''}"

    render: ->
      div {className: 'footer'},
        span {}, "© #{@props.years} "
        a {href: 'mailto:photo@karenishe.com'}, 'Karén'
        span {}, ' – All rights reserved'