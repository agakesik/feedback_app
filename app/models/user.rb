class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false, message: "imię nie może się powtarzać"}
  has_many :ratings, dependent: :destroy
  belongs_to :skater_status
  default_scope -> { order(created_at: :desc) }
  has_secure_password :validations => false
  validates :password, presence: true, length: { minimum: 6 }, if: :activated
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                              format: { with: VALID_EMAIL_REGEX },
                              uniqueness: true, allow_nil: true
  validates :email, presence: true, if: :activated

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
