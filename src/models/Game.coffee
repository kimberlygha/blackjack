class window.Game extends Backbone.Model
  initialize: (params) ->
    _.bindAll @
    @set 'dealerHand', params.dealerHand
    @set 'playerHands', params.playerHands
    @set 'deck', params.deck
    @set 'playerScore', 100
    self = @get 'playerHands'
    self[0].bind 'hit', @handleHit
    self[0].bind 'split', @splitHand

  defaults:
    betAmount: 0

  handleFlip: -> 
    currentDealerHand = @get 'dealerHand'
    currentDealerHand.first().flip()
    @handleStand()

      # listen to stand events
      # check if dealer is > 17
        # if not, keep flipping the dealer until 21
      # if yes, then we call gameover

  handleStand: ->
    currentDealerHandTwo = @get 'dealerHand'
    if currentDealerHandTwo.scores()[0] is currentDealerHandTwo.scores()[1]
      if currentDealerHandTwo.scores()[0] < 17
        currentDealerHandTwo.hit()
        @handleStand()
      else
        @handleGameover()
    else 
      if currentDealerHandTwo.scores()[1] < 21 and currentDealerHandTwo.scores()[1] > 17
        @handleGameover()
      else if currentDealerHandTwo.scores()[0] < 17 
        currentDealerHandTwo.hit()
        @handleStand()
      else 
        @handleGameover()


    # listen to hit events
      # just check the score to keep it less than 21
  handleHit: -> 
    selfTwo = @get 'playerHands'
    currentScoreForHit = selfTwo[0].scores()
    @handleGameover() if currentScoreForHit[0] > 21

# have a gameover method to handle gameover
  # send a game over event for app model to listen to
  # app view listens to game over and updates
  handleGameover: -> 
    currentPlayerScoreForGameOver = @get('playerHands')[0].scores()
    if currentPlayerScoreForGameOver[0] isnt currentPlayerScoreForGameOver[1]
      currentPlayerBest = if currentPlayerScoreForGameOver[1] < 21 then currentPlayerScoreForGameOver[1] else currentPlayerScoreForGameOver[0]
    else 
      currentPlayerBest = currentPlayerScoreForGameOver[0]

    currentDealerScoreForGameOver = @get('dealerHand').scores()
    if currentDealerScoreForGameOver[0] isnt currentDealerScoreForGameOver[1] 
      currentDealerBest = if currentDealerScoreForGameOver[1] < 21 then currentDealerScoreForGameOver[1] else currentDealerScoreForGameOver[0]
    else 
      currentDealerBest = currentDealerScoreForGameOver[0]

    # game logic to handle win lose or tie
    if currentPlayerBest > 21
      newScoreLose =  @get('playerScore') - @get('betAmount')
      @set 'playerScore', newScoreLose
      alert "you suuuuuuck! Your score is now: " + newScoreLose
      @trigger 'gameEnd', @

    else if currentPlayerBest < currentDealerBest and currentDealerBest < 21
      newScoreLose =  @get('playerScore') - @get('betAmount')
      @set 'playerScore', newScoreLose
      alert "you suuuuuuck! Your score is now: " + newScoreLose
      @trigger 'gameEnd', @

    else if currentPlayerBest > currentDealerBest or currentDealerBest > 21
      newScoreWin =  @get('playerScore') + @get('betAmount')
      @set 'playerScore', newScoreWin
      alert "you win!! Your score is now: " + parseInt(newScoreWin, 10)
      @trigger 'gameEnd', @
      
    else if currentPlayerBest == currentDealerBest
      currentScore = @get 'playerScore'
      alert "Bummer, you tied! Your score is now: " + currentScore
      @trigger 'gameEnd', @

    else 
      alert 'Error occured. Play again'

  splitHand: -> 
    selfThree = @get 'playerHands'
    selfFour = @get 'deck'
    newHand = new Hand [selfThree[0].pop(), selfFour.pop()], selfFour
    selfThree[0].hit();
    selfThree.add(newHand);
    @trigger 'splitHand', @





