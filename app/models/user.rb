class User < ActiveRecord::Base

  has_many :microposts

  # Create a getter & a setter for remember_token, activation_token, & reset_token.
  attr_accessor :remember_token, :activation_token, :reset_token

  # Downcase the email attribute before saving the user. Applies on
  # both create & update.
  before_save   :downcase_email

  # Assign the token and corresponding digest
  before_create :create_activation_digest


  before_save { self.email = self.email.downcase }


	# Name validations
  validates :name, presence: true
  validates :name, length: { maximum: 50 }


	# Email validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }


  # Password validations
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
      # Note that has_secure_password enforces presence validations upon object
      # creation, so allow_blank only applies on settings update, to account for the
      # case where user only wishes to update their email, not their password


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  # A generalized 'authenticated?' method.
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end


  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end


  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end


  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


 
  private # ----------------------------------------------

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
