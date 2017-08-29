require 'test_helper'

class CardTest < ActiveSupport::TestCase

  def setup
    @deck = decks(:qforhum)
    @card = @deck.cards.build(lens_prefix: "The Lens of", lens_name: "You")
  end

  test "should be valid" do
    assert @card.valid?
  end

  test "deck id should be present" do
    @card.deck_id = nil
    assert_not @card.valid?
  end

  test "lens name should be unique for each card in deck" do
    duplicate_card = @card.dup
    other_deck = decks(:one)
    other_card = Card.new(lens_prefix: "The Lens of", lens_name: "You", deck_id: other_deck.id)
    @card.save
    assert_not duplicate_card.valid?
    assert other_card.valid?
  end
end
