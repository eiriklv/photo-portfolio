define ['backbone', 'CamModel'], (Backbone, CamModel) ->
  Backbone.Collection.extend
    model: CamModel
    url: '/api/cams'
    comparator: (b, a) ->
      if a.id > b.id then 1
      else if a.id is b.id then 0
      else -1

