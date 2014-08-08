define ['backbone'], (Backbone) ->
  Backbone.Model.extend
    defaults:
      name: null
      description: null
      position: null
      views: null
      album_id: null
      cam_id: null
      lens_id: null
      iso: null
      aperture: null
      exposure: null
      focal_distance: null
      thumb_url: null
      thumb_x2_url: null
      normal: null
      large: null
      xlarge: null