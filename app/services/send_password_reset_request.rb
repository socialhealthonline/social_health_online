class SendPasswordResetRequest

  def initialize(user)
    @user = user
  end

  def call
    # generate a new auth token
    @user.password_reset_token = SecureRandom.hex(6)
    @user.save(validate: false)
    # update the password reset sent_at
    @user.touch(:password_reset_sent_at)
    # deliver the email
    UserMailer.password_reset(@user).deliver
  end
end
