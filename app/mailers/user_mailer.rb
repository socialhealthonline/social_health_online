class UserMailer < ApplicationMailer
  default from: '"Social Health Online" <support@socialhealthonline.com>'

  def welcome(user)
    @user = user
    mail to: user.email, subject: '[Social Health Online] Welcome'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: '[Social Health Online] Password Reset Request'
  end

  def registration_confirmation(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: '[Social Health Online] Registration Confirmation'
  end
end
