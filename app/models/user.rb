class User < ApplicationRecord
  # adds virtual attributes for authentication
  has_secure_password
  # validates email
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true
  def generate_password_reset_token!
    token = SecureRandom.hex
    update(reset_password_token: token)
    token
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) < Time.now.utc
  end

  def reset_password(params)
    pp params[:password]
    pp params[:password_confirmation]
    
    if params[:password] == params[:password_confirmation]
      self.reset_password_token = nil
      self.password = password
      self.save
    else
      false
    end
  end
end