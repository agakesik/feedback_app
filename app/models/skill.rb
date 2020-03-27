class Skill < ApplicationRecord
  belongs_to :skills_category
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false}
end
