define ['backbone', 'LensModel'], (Backbone, LensModel) ->
  Backbone.Collection.extend
    model: LensModel
    url: '/api/lenses'
    comparator: (b, a) ->
      if a.id > b.id then 1
      else if a.id is b.id then 0
      else -1

