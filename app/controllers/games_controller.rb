class GamesController < ApplicationController
  def who_am_i
    @deck = Deck.featured
    @celebrities = Celebrity.all
    @card = Card.first
  end
end
