define ['react', 'TelegraphMixin', 'ReactBackboneMixin'], (React, TelegraphMixin, ReactBackboneMixin) ->

  {div, img, i, span, br, strong} = React.DOM
  cx = React.addons.classSet

  React.createClass
    displayName: 'PhotoLargeComponent'
    mixins: [TelegraphMixin, ReactBackboneMixin]

    extraBackboneCollections: ['cams', 'lenses']
    firstLoad: false
    
    getDefaultProps: ->
      model: {}
      cams: {}
      lenses: {}

    getInitialState: ->
      loading: false
      imgURL: null
      visible: false

    componentWillMount: ->
      @onWindowResize()
      @props.cams.fetch()
      @props.lenses.fetch()

    componentDidMount: ->
      if window.addEventListener?
        window.addEventListener 'resize', @onWindowResize
      @firstLoad = true
    
    componentWillUnmount: ->
      if window.removeEventListener?
        window.removeEventListener 'resize', @onWindowResize
    
    componentDidUpdate: ->
      @onWindowResize()
    
    onWindowResize: ->
      windowSize = @windowSize()
      windowMaxDim = Math.max windowSize.width, windowSize.height
      
      imgURL = if windowMaxDim > 2562 then @props.model.get('xlarge')
      else if windowMaxDim > 1281 then @props.model.get('large')
      else @props.model.get('normal')

      unless @state.imgURL is imgURL
        @setState
          imgURL: imgURL
          loading: true
    
    onLoad: ->
      @setState loading: false
      if @firstLoad
        @firstLoad = false
        setTimeout =>
          @setState visible: true
    
    onCloseButtonClick: ->
      @setState visible: false
      setTimeout =>
        @upstream 'photoLarge:close'
        Current.Router.navigate "photo/#{Current.albumId or 'all'}"
      , 300

    windowSize: ->
      ret =
        width: 0
        height: 0
      
      if document.body? and document.body.offsetWidth?
        ret =
          width: document.body.offsetWidth
          height: document.body.offsetHeight

      if document.compatMode is 'CSS1Compat' and document.documentElement? and document.documentElement.offsetWidth?
        ret =
          width: document.documentElement.offsetWidth
          height: document.documentElement.offsetHeight

      if window.innerWidth? and window.innerHeight?
        ret =
          width: window.innerWidth
          height: window.innerHeight

      pixelRatio = if window.devicePixelRatio? then window.devicePixelRatio
      else 1

      ret =
        width: ret.width * pixelRatio
        height: ret.height * pixelRatio
    
    camName: ->
      camId = @props.model.get('cam_id')
      cam = @props.cams.get camId
      return cam.get('name') if cam?
      ''

    lensName: ->
      lensId = @props.model.get('lens_id')
      lens = @props.lenses.get lensId
      return lens.get('name') if lens?
      ''
    
    onPrevClick: ->
      @setState visible: false
      setTimeout =>
        @firstLoad = true
        @upstream 'photoLarge:prev'
        setTimeout =>
          @setState visible: true
      , 300

    onNextClick: ->
      @setState visible: false
      setTimeout =>
        @firstLoad = true
        @upstream 'photoLarge:next'
        setTimeout =>
          @setState visible: true
      , 300
    
    onFacebookClick: ->
      FB.ui
        method: 'share'
        href: window.location.href
        display: 'iframe'
      , (response) ->
        if console? and console.log?
          console.log response

      window.YandexCounter.reachGoal 'FB_SHARE_CLICK' if window.YandexCounter?
    
    render: ->
      classes = cx
        largePhoto: true
        visible: @state.visible and not @state.loading
      
      loaderClasses = cx
        loader: true
        visible: @state.loading
      
      likes = @props.model.get 'likes'
      comments = @props.model.get 'comments'
      
      div {className: classes},
        div {className: 'photosContainer'},
          img {className: 'photo', src: @state.imgURL, onLoad: @onLoad}
        div {className: loaderClasses}
        div {className: 'closeButton', onClick: @onCloseButtonClick},
          i {className: 'fa fa-times'}
        div {className: 'about'},
          span {className: 'name'}, @props.model.get 'name'
          br {}
          span {className: 'description'}, @props.model.get 'description'
          br {}
          span {className: 'social'},
            if likes
              div {},
                i {className: 'fa fa-thumbs-up'}
                span {}, likes
            if comments
              div {},
                i {className: 'fa fa-comments'}
                span {}, comments
            i {className: 'fa fa-facebook-square', onClick: @onFacebookClick}, ' share'
        div {className: 'techSpec'},
          span {className: 'row'},
            span {}, 'Camera: '
            strong {}, @camName()
          br {}
          span {className: 'row'},
            span {}, 'Lens: '
            strong {}, @lensName()
          br {}
          span {className: 'row'},
            span {}, 'Exif: '
            strong {}, "ISO #{@props.model.get('iso')}, #{@props.model.get('focal_distance')}mm, f#{@props.model.get('aperture')}, #{@props.model.get('exposure')}s"
        div {className: 'prev', onClick: @onPrevClick},
          i {className: 'fa fa-angle-left'}
        div {className: 'next', onClick: @onNextClick},
          i {className: 'fa fa-angle-right'}