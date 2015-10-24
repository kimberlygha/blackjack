class window.Game extends Backbone.Model
  initialize: (params) ->
    @set 'dealerHand', params.dealerHand
    @set 'playerHand', params.playerHand

    # listen to stand events
      # check if dealer is > 17
        # if not, keep flipping the dealer until 21
      # if yes, then we call gameover
  handleStand: ->
    currentDealerHand = @get 'dealerHand' 
    currentDealerHand.first().flip()
    if currentDealerHand.scores.length == 1
      if currentDealerHand.scores[0] < 17
        currentDealerHand.hit()
        @handleStand()
      else
        @handleGameover()
    else 
      if currentDealerHand.scores[1] < 21 and currentDealerHand.scores[1] > 17
        @handleGameover()
      else if currentDealerHand.scores[0] < 17 
        @currentDealerHand.hit()
      else 
        @handleGameover()


    # listen to hit events
      # just check the score to keep it less than 21
  handleHit: -> 
    currentScore = @get 'playerHand'.scores()
    @handleGameover() if currentScore > 21

  handleGameover: -> 
# have a gameover method to handle gameover
  # send a game over event for app model to listen to
  # app view listens to game over and updates
