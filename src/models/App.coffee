# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'
    deck = @get 'deck'
    gameModel = new Game(playerHand: playerHand, dealerHand: dealerHand, deck: deck)
    @set 'gameModel', gameModel

