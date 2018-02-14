class ContactMailer < ApplicationMailer
  default from: '"Social Health Online" <info@socialhealthonline.com>'

  def notify(form_params)
    @form_params = form_params
    mail to: 'info@socialhealthonline.com', subject: '[Social Health Online] New Contact Submission'
  end

end
