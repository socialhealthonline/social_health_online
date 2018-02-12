class ContactMailerPreview < ActionMailer::Preview

  def notify
    form_params = {}
    form_params[:name] = 'Tom Jones'
    form_params[:email] = 'tom@example.com'
    form_params[:message] = 'Just a test.'
    ContactMailer.notify(form_params)
  end

end
