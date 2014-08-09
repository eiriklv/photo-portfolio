define ['react'], (React) ->

  {div, img, h1, p, i} = React.DOM
  cx = React.addons.classSet

  React.createClass
    displayName: 'PhotoLargeComponent'
    
    render: ->
      imgURL = if window.devicePixelRatio > 1 then '/me_x2.jpg'
      else '/me.jpg'

      div {className: 'aboutPage'},
        h1 {}, 'Karén Ka'
        img {width: 500, height: 333, src: imgURL}
        p {}, '"People spot a big black lens, and they worry about what they\'re doing, or how their hair looks. Nobody see the person holding the camera."'
        i {}, 'Erica O\'Rourke'