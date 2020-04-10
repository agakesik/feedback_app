class RatingValue < ApplicationRecord
  has_many :ratings
  validates :value, presence: true, uniqueness: true
end
