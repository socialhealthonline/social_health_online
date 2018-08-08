class UserMailer < ApplicationMailer
  default from: '"Social Health Online" <support@socialhealthonline.com>'

  def welcome(user)
    @user = user
    mail to: user.email, subject: 'Welcome - Social Health Online'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset Request - Social Health Online'
  end

  def registration_confirmation(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: 'Registration Confirmation - Social Health Online'
  end
end
