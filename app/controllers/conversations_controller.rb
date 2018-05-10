class ConversationsController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = authenticated_user.send_message(recipients,
                                                   conversation_params[:body],
                                                   conversation_params[:subject]).conversation
    flash[:success] = 'Your message was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  def show
    @receipts = conversation.receipts_for(authenticated_user)
    conversation.mark_as_read(authenticated_user)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

end
