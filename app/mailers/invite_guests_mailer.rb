class InviteGuestsMailer < ApplicationMailer
  def notify(form_params, authenticated_user)
    @form_params = form_params
    @authenticated_user = authenticated_user

    mail to: '@form_params[:email]',
         subject: '[Social Health Online] Join Me In Social Health Online',
         from: "#{authenticated_user.name} <#{authenticated_user.email}>"
  end
end
