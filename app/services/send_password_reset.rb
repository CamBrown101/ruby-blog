class SendPasswordReset
  attr_reader :user, :mailer

  def self.call(user)
    instance = new(user)
    instance.call
  end

  def initialize(user, mailer = PasswordMailer)
    @user = user
    @mailer = mailer
  end

  def call
    user.update(reset_password_token: generate_token)
    mailer.with(user: @user).reset.deliver_later
  end

  private
  def generate_token
    SecureRandom.hex
  end
end