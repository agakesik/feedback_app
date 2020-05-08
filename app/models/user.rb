class User < ApplicationRecord
  mattr_accessor :activation_token, :reset_token
  mattr_accessor :activation_email_send, default: false
  before_save :downcase_email
  # before_save :create_activation_digest
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
                              uniqueness: true, allow_blank: true, allow_nil: true
  validates :email, presence: true, if: :activating

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

  # Returnrs true if given token matches digest
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_activation_digest
    self.activation_token = User.new_token
    update_columns(activation_digest: User.digest(activation_token))
  end

  def create_reset_digest
    self.reset_token  = User.new_token
    update_columns(reset_digest: User.digest(reset_token))
    update_columns(reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def downcase_email
      unless email.blank?
        self.email = email.downcase
      end
    end


end
