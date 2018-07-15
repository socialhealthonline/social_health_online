class AffiliatesRegistrationMailer < ApplicationMailer
  default from: '"Social Health Online" <hello@socialhealthonline.com>'

  def notify(form_params)
    @form_params = form_params
    mail to: 'sales@socialhealthonline.com', subject: '[Social Health] New Affiliate Registration Submission'
  end

end
