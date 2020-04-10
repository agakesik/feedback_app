class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  belongs_to :rating_value
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :skill_id, presence: true
end
