class Rating < ApplicationRecord
  validates :user_id, presence: true
  validates :skill_id, presence: true
  validates :value, inclusion: { in: 1..5 }
  belongs_to :user
  belongs_to :skill
end
