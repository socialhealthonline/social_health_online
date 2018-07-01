class IssuesMailer < ApplicationMailer
  def notify(form_params, authenticated_user)
    @form_params = form_params
    @authenticated_user = authenticated_user

    mail to: 'support@socialhealthonline.com',
         subject: '[Social Health Online] New Issue(s)',
         from: "#{authenticated_user.name} <#{authenticated_user.name}>"
  end
end
