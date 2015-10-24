assert = chai.assert

describe 'game', ->
  deck = null
  playerhands = null
  dealerhand = null
  game = null

  beforeEach ->
    deck = new Deck()
    playerhands = [deck.dealPlayer()]
    dealerhand = deck.dealDealer()
    game = new Game(playerHands: playerhands, dealerHand: dealerhand, deck: deck)

  describe 'hit', ->
    it 'should add a card to the playerhand when hit is called', ->
      playerhands[0].hit()
      assert.strictEqual playerhands[0].length, 3

  describe 'flip card on stand', ->
    it 'should flip the dealer hidden card when stand is called', ->
      game.handleFlip()
      assert.strictEqual dealerhand.first().get('revealed'), true

  describe 'dealer continues to play on stand', ->
    it 'should hit the dealer until > 17 when stand is called', ->
      game.handleFlip()
      assert.strictEqual dealerhand.scores()[1] > 16, true 


  describe 'player score increments with each hit', ->
    it 'should increment playerscore with each hit', ->
      playerhands[0].hit()
      playerhands[0].hit()
      playerhands[0].hit()
      playerhands[0].hit()
      playerhands[0].hit()
      playerhands[0].hit()
      assert.strictEqual playerhands[0].scores()[0] > 21, true

  describe 'game betting system', ->
    it 'should output the right score for the player after a bet is placed', ->
      game.set 'betAmount', 20
      playerhands[0].models[0].set('value', 10)
      playerhands[0].models[1].set('value', 10)
      dealerhand.models[0].set('value', 9)
      dealerhand.models[1].set('value', 9)
      game.handleFlip()
      assert.strictEqual game.get('playerScore'), 120 



