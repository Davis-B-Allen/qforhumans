class Card < ApplicationRecord
  belongs_to :deck
  validates :deck_id, presence: true
end
