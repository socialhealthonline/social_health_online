class EventSuggestionsMailer < ApplicationMailer
  def notify(form_params, authenticated_user)
    @form_params = form_params
    @authenticated_user = authenticated_user

    mail :to => authenticated_user.member.primary_manager.email,
         subject: 'Community Event Suggestions - Social Health Online',
         from: "#{authenticated_user.name} <#{authenticated_user.email}>"
  end
end
