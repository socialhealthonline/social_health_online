class AffiliatesRegistrationMailer < ApplicationMailer
  default from: '"Social Health" <sales@socialhealthonline.com>'

  def notify(form_params)
    @form_params = form_params
    mail to: 'sales@socialhealthonline.com', subject: 'New Affiliate Registration Submission - Social Health'
  end

end
