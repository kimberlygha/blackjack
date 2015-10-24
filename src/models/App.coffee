# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    newPlayer = deck.dealPlayer()
    console.log newPlayer
    newPlayerArr = []
    newPlayerArr.push newPlayer
    @set 'playerHands', newPlayerArr
    @set 'dealerHand', deck.dealDealer()
    playerHands = @get 'playerHands'
    dealerHand = @get 'dealerHand'
    playerHands = @get 'playerHands'
    deck = @get 'deck'
    gameModel = new Game(playerHands: playerHands, dealerHand: dealerHand, deck: deck)
    @set 'gameModel', gameModel

