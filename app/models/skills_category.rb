class SkillsCategory < ApplicationRecord
  has_many :skills
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false}
end
