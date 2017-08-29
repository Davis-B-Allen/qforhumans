require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @deck = decks(:qforhum)
    @card = Card.new(lens_prefix: "The Lens of", lens_name: "You", deck_id: @deck.id)
    # @card = @deck.cards.build(lens_prefix: "The Lens of", lens_name: "You")
  end

  test "should be valid" do
    assert @card.valid?
  end

  test "deck id should be present" do
    @card.deck_id = nil
    assert_not @card.valid?
  end
end
