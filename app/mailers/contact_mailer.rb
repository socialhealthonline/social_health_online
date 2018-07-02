class ContactMailer < ApplicationMailer
  default from: '"Social Health" <info@socialhealthonline.com>'

  def notify(form_params)
    @form_params = form_params
    mail to: 'info@socialhealthonline.com', subject: '[Social Health] New Contact Submission'
  end

end
