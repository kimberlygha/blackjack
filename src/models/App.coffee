# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    gameModel = new Game(playerHand: playerHand, dealerHand: dealerHand)
    @set 'gameModel', gameModel

# add a collection (in initialize) to the app? have it be the hands
# Model should listen to a 'stand' occuring on hand.cofdee
#  and then run it's own dealerhand

# need functionality to clear board and reset the game 
# 
