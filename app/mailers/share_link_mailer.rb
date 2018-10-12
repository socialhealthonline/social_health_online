class ShareLinkMailer < ApplicationMailer
  def notify(form_params, authenticated_user)
    @form_params = form_params
    @authenticated_user = authenticated_user
    email = @form_params[:email]

    mail :to => email,
         subject: 'Shared Link - Social Health Online',
         from: "#{authenticated_user.name} <#{authenticated_user.email}>"
  end
end
