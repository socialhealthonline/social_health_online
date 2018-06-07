class SendPasswordResetRequest

  def initialize(user)
    @user = user
  end

  def call
    # generate a new auth token
    # @user.regenerate_password_reset_token
    @user.save(password_reset_token: SecureRandom.hex,validate: false)
    # update the password reset sent_at
    @user.touch(:password_reset_sent_at)
    # deliver the email
    UserMailer.password_reset(@user).deliver
  end
end
