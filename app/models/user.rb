class User < ApplicationRecord
  attr_accessor :activation_token
  before_save :downcase_email
  before_save :create_activation_digest
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false, message: "imię nie może się powtarzać"}
  has_many :ratings, dependent: :destroy
  belongs_to :skater_status
  default_scope -> { order(created_at: :desc) }
  has_secure_password :validations => false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true,
                       if: :activated
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                              format: { with: VALID_EMAIL_REGEX },
                              uniqueness: true, allow_blank: true
  validates :email, presence: true, if: :activated

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  private

    def downcase_email
      unless email.blank?
        self.email = email.downcase
      end
    end

    def create_activation_digest
      if self.activated && self.password.blank?
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
      end
    end

end
