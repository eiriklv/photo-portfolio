define [], () ->

  class YandexCounter
    counter: null
    intervalID: null

    constructor: (@COUNTER_ID) ->
      @intervalID = setInterval @waitForCounter, 100

    waitForCounter: =>
      return unless Ya?
      clearInterval @intervalID if @intervalID
      @initCounter()

    initCounter: ->
      @counter = new Ya.Metrika
        id: @COUNTER_ID
        enableAll: true
  
    reachGoal: (goalID) ->
      if @counter and goalID
        # p "reachGoal: #{goalID}"
        @counter.reachGoal goalID

  window.YandexCounter = new YandexCounter 25825595