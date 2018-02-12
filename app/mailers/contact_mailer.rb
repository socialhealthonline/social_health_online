class ContactMailer < ApplicationMailer
  default from: '"Social Health Online" <hello@socialhealthonline.com>'

  def notify(form_params)
    @form_params = form_params
    mail to: ['james.quillen@gmail.com', 'alex.a.ulbricht@gmail.com'], subject: '[Social Health Online] New Contact Submission'
  end

end
