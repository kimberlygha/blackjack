assert = chai.assert

describe 'game', ->
  deck = null
  playerhand = null
  dealerhand = null
  game = null

  beforeEach ->
    deck = new Deck()
    playerhand = deck.dealPlayer()
    dealerhand = deck.dealDealer()
    game = new Game(playerHand: playerHand, dealerHand: dealerHand)

  describe 'win', ->
    it 'should return a win', ->
      spyOn(game, 'handleGameOver')
      assert.strictEqual deck.length, 50
      assert.strictEqual playerhand.set 'scores', [21, 21]
      assert.strictEqual dealerhand.set 'scores' [18, 18]
      expect(game.handleGameOver).toHaveBeenCalledWith('you win!!')

