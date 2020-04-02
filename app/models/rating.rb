class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :skill_id, presence: true
  validates :value, inclusion: { in: 1..5 }
end
