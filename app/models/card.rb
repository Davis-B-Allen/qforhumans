class Card < ApplicationRecord
  belongs_to :deck
  has_many :answers
  has_many :celebrities, through: :answers
  scope :card_ordered, -> { order(face_number: :asc, face_suit: :asc) }
  mount_uploader :image, PictureUploader
  validates :deck_id, presence: true
  validates :lens_name, presence: true, uniqueness: { scope: :deck_id }
end
