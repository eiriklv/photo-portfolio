define ['backbone', 'PhotoModel'], (Backbone, PhotoModel) ->
  PhotosCollection = Backbone.Collection.extend
    model: PhotoModel
    url: '/api/photos'
    comparator: (b, a) ->
      if a.position > b.position then 1
      else if a.position is b.position then 0
      else -1
    byAlbumId: (albumId) ->
      filtered = @filter (photo) ->
        photo.get('album_id') is albumId
      new PhotosCollection filtered