define ['backbone', 'AlbumModel'], (Backbone, AlbumModel) ->
  Backbone.Collection.extend
    model: AlbumModel
    url: '/albums'
    comparator: (b, a) ->
      if a.position > b.position then 1
      else if a.position is b.position then 0
      else -1

