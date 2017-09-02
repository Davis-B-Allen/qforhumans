class Card < ApplicationRecord
  belongs_to :deck
  default_scope -> { order(face_number: :asc, face_suit: :asc) }
  validates :deck_id, presence: true
  validates :lens_name, presence: true, uniqueness: { scope: :deck_id }
end
