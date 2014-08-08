define ['react', 'TelegraphMixin', 'ReactBackboneMixin'], (React, TelegraphMixin, ReactBackboneMixin) ->

  {div, img, i, span, br, strong} = React.DOM
  cx = React.addons.classSet

  React.createClass
    displayName: 'PhotoLargeComponent'
    mixins: [TelegraphMixin, ReactBackboneMixin]

    extraBackboneCollections: ['cams', 'lenses']
    
    getDefaultProps: ->
      model: {}
      cams: {}
      lenses: {}

    getInitialState: ->
      loading: false
      imgURL: null

    componentWillMount: ->
      @onWindowResize()
      @props.cams.fetch()
      @props.lenses.fetch()

    componentDidMount: ->
      if window.addEventListener?
        window.addEventListener 'resize', @onWindowResize
    
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
    
    onCloseButtonClick: ->
      @upstream 'photoLarge:close'

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
      @upstream 'photoLarge:prev'

    onNextClick: ->
      @upstream 'photoLarge:next'
    
    render: ->
      loaderClasses = cx
        loader: true
        visible: @state.loading
      
      div {className: 'largePhoto'},
        div {className: 'photosContainer'},
          img {className: 'photo', src: @state.imgURL, onLoad: @onLoad}
        div {className: loaderClasses}
        div {className: 'closeButton', onClick: @onCloseButtonClick},
          i {className: 'fa fa-times'}
        div {className: 'about'},
          span {className: 'name'}, @props.model.get 'name'
          br {}
          span {className: 'description'}, @props.model.get 'description'
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