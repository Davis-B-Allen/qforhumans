class Card < ApplicationRecord
  belongs_to :deck
  validates :deck_id, presence: true
  validates :lens_name, presence: true, uniqueness: { scope: :deck_id }
end
