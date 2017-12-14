class Celebrity < ApplicationRecord
  has_many :answers
  has_many :cards, through: :answers
  validates :name, presence: true, uniqueness: true
end
