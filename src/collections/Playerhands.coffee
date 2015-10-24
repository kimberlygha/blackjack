class window.Playerhands extends Backbone.Collection
  model: Card

  initialize: (array) ->

  defaults:
    totalHands: []

    # check if both cards are the same when first dealt
      # if yes, then push this hand to the playerhand collections
    # GAME MODEL CHANGES:
      #update "handleHit" to work on the first playerHand in the playerhand collections
      #update "gameOver" to only do lose and tie IF there are no more playerhands left

    #CHIPS:
      # belong in the Hand model (attached to every hit)?
        # before every hit, they get a prompt asking them how much they want to bet
        # the game model should listen for bets update the game's bets 
        # or should the total for each of the scores belong in the playerHands collection?

