define ['backbone', 'PhotoModel'], (Backbone, PhotoModel) ->
  Backbone.Collection.extend
    model: PhotoModel
    url: '/photos'
    comparator: (b, a) ->
      if a.position > b.position then 1
      else if a.position is b.position then 0
      else -1

