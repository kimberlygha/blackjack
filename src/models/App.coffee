# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    # need to create a new collection to hold all the player hands 
    # check if both cards are the same when first dealt
      # if yes, then push this to the playerhand collections
    # GAME MODEL CHANGES:
      #update "handleHit" to work on the first playerHand in the playerhand collections
      #update "gameOver" to only do lose and tie IF there are no more playerhands left
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    gameModel = new Game(playerHand: playerHand, dealerHand: dealerHand)
    @set 'gameModel', gameModel

