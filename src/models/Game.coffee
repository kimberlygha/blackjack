class window.Game extends Backbone.Model
  initialize: (params) ->
    _.bindAll @
    @set 'dealerHand', params.dealerHand
    @set 'playerHand', params.playerHand
    self = @get 'playerHand'
    self.bind 'hit', @handleHit

    # listen to stand events
      # check if dealer is > 17
        # if not, keep flipping the dealer until 21
      # if yes, then we call gameover

  handleFlip: -> 
    currentDealerHand = @get 'dealerHand'
    currentDealerHand.first().flip()
    @handleStand()
  handleStand: ->
    if currentDealerHand.scores()[0] or currentDealerHand.scores()[1]
      if currentDealerHand.scores()[0] < 17
        currentDealerHand.hit()
        @handleStand()
      else
        @handleGameover()
    else 
      if currentDealerHand.scores()[1] < 21 and currentDealerHand.scores()[1] > 17
        @handleGameover()
      else if currentDealerHand.scores()[0] < 17 
        currentDealerHand.hit()
      else 
        @handleGameover()


    # listen to hit events
      # just check the score to keep it less than 21
  handleHit: -> 
    selfTwo = @get 'playerHand'
    currentScoreForHit = selfTwo.scores()
    @handleGameover() if currentScoreForHit[0] > 21

# have a gameover method to handle gameover
  # send a game over event for app model to listen to
  # app view listens to game over and updates
  handleGameover: -> 
    currentPlayerScoreForGameOver = @get('playerHand').scores()
    if currentPlayerScoreForGameOver != null 
      currentPlayerBest = if currentPlayerScoreForGameOver[1] < 21 then currentPlayerScoreForGameOver[1] else currentPlayerScoreForGameOver[0]
    else 
      currentPlayerBest = currentPlayerScoreForGameOver[0]

    currentDealerScoreForGameOver = @get('dealerHand').scores()
    if currentDealerScoreForGameOver != null 
      currentDealerBest = if currentDealerScoreForGameOver[1] < 21 then currentDealerScoreForGameOver[1] else currentDealerScoreForGameOver[0]
    else 
      currentDealerBest = currentDealerScoreForGameOver[0]

    # @trigger 'lose' if currentPlayerBest < currentDealerBest or currentPlayerBest > 21
    if currentPlayerBest < currentDealerBest or currentPlayerBest > 21 
      alert "you suuuuuuck!"

    if currentPlayerBest > currentDealerBest and currentPlayerBest < 21
      alert "you win!!"

    if currentPlayerBest == currentDealerBest
      alert "Bummer, you tied!"





