define ['react'], (React) ->

  {div, h1, i, a, span} = React.DOM
  cx = React.addons.classSet

  React.createClass
    displayName: 'PhotoLargeComponent'
    
    render: ->
      div {className: 'contactPage'},
        h1 {}, 'Contact'
        a {href: 'https://www.flickr.com/photos/126027715@N08/sets', target: '_blank'},
          i {className: 'fa fa-flickr'}
          span {}, 'Flickr'
        a {href: 'https://github.com/karen2k/', target: '_blank'},
          i {className: 'fa fa-github-square'}
          span {}, 'GitHub'
        a {href: 'https://www.facebook.com/karenishe', target: '_blank'},
          i {className: 'fa fa-facebook-square'}
          span {}, 'Facebook'
        a {href: 'mailto:photo@karenishe.com'},
          i {className: 'fa fa-envelope-square'}
          span {}, 'photo@karenishe.com'