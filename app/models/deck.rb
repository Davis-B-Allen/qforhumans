class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy

  # returns the featured deck
  # NOTE: currently ok this way as decks must be created manually
  # but need to change this once more decks can be created through web
  def self.featured
    self.last
  end
end
