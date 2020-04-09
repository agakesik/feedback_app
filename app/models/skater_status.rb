class SkaterStatus < ApplicationRecord
  has_many :users
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false,
                                 message: "Nazwa nie może się powtarzać"}
end
