class UserMailer < ApplicationMailer
  default from: '"Social Health Online" <info@socialhealthonline.com>'

  def welcome(user)
    @user = user
    mail to: user.email, subject: '[Social Health Online] Welcome'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: '[Social Health Online] Password Reset Request'
  end

end
