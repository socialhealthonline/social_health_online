class ServiceSupportMailer < ApplicationMailer
  def notify(form_params, authenticated_user)
    @form_params = form_params
    @authenticated_user = authenticated_user

    mail :to => 'support@socialhealthonline.com',
         subject: 'Service Support Request - Social Health Online',
         from: "#{authenticated_user.name} <#{authenticated_user.email}>"
  end
end
