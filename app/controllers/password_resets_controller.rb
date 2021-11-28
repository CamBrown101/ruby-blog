class PasswordResetsController < ApplicationController
  def new; end
  def create
    user = User.find_by(email: params[:email])
    SendPasswordReset.(user) if user
    redirect_to root_path, notice: 'Please check your email to reset the password'
  end

  def edit
    # finds user with a valid token
    @user = User.find_by(reset_password_token: params[:token])
    # rescue ActiveSupport::MessageVerifier::InvalidSignature
    unless @user.password_token_valid?
      redirect_to sign_in_path, alert: 'Your token has expired. Please try again.'
    end
  end

  def update
    # updates user's password
    @user = User.find_by_reset_password_token(params[:token])
    if @user.reset_password(password_params)
      redirect_to sign_in_path, notice: 'Your password was reset successfully. Please sign in'
    else
      render :edit
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end