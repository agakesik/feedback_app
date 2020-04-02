class Skill < ApplicationRecord
  belongs_to :skills_category
  has_many :ratings, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false}
end
