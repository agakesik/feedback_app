class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false, message: "imię nie może się powtarzać"}
  has_many :ratings, dependent: :destroy
  belongs_to :skater_status
  default_scope -> { order(created_at: :desc) }
end
